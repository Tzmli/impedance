# ImpedanceMatching: Maximum gain impedance matching calculator
module Matchings
  class Impedance
    attr_accessor :s11, :s12, :s21, :s22

    def initialize(**args)
      @s11 = args[:s11] || Complex(0, 0)
      @s12 = args[:s12] || Complex(0, 0)
      @s21 = args[:s21] || Complex(0, 0)
      @s22 = args[:s22] || Complex(0, 0)
      yield(self) if block_given?
    end

    def ds
      @ds ||= s11*s22 - s12*s21
    end

    def k
      @k ||= (1 + ds.abs**2 - s11.abs**2 - s22.abs**2) / (2 * s21.abs * s12.abs)
    end

    def b1
      @b1 ||= 1+ s11.abs**2 - s22.abs**2 - ds.abs**2
    end

    def mag
      if b1 < 0
        Math.log10(s21.abs/s12.abs) + Math.log10((k + Math.sqrt((k**2)-1).abs))
      else
        Math.log10(s21.abs/s12.abs) + Math.log10((k - Math.sqrt((k**2)-1).abs))
      end * 10
    end

    def c2
      @c2 ||= s22 - ds*s11.conjugate
    end

    def b2
      @b2 ||= 1 + s22.abs**2 - s11.abs**2 - ds.abs**2
    end

    def gama_l_magnitude
      @gama_l_magnitude ||= if b2.positive?
        (b2 - Math.sqrt(b2**2 - 4*(c2.abs**2))) / (2 * c2.abs)
      else
        (b2 + Math.sqrt(b2**2 - 4*(c2.abs**2))) / (2 * c2.abs)
      end
    end

    def gama_l
      @gama_l ||= Complex.polar_grads(gama_l_magnitude, -1*(c2.angle_grads))
    end

    def gama_s
      @gama_s ||= (s11 + ( (s12*s21*gama_l) / (1 - (gama_l*s22)) ) ).conjugate
    end

    def results
      """
        s11 = #{s11}
        s12 = #{s12}
        s21 = #{s21}
        s22 = #{s22}
      ==========================================
         Ds = #{ds}
          K = #{k.round(5)}
         B1 = #{b1.round(5)}
        MAG = #{mag.round(5)} [dB]
         C2 = #{c2}
         B2 = #{b2.round(5)}
       |ΓL| = #{gama_l_magnitude.round(5)}
         ΓL = #{gama_l}
         Γs = #{gama_s}
      """
    end
  end
end
