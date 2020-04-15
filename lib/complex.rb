# Monkey patch for complex methods
class Complex
  def self.polar_grads(radius, angle)
    Complex.polar(radius, angle * (Math::PI / 180.0))
  end

  def radius
    self.polar.first
  end

  def angle_grads
    angle * (180 / Math::PI)
  end

  def to_s
    "r #{radius.round(5).to_s.ljust(3)} ∠ #{angle_grads.round(5)}"
  end
end
