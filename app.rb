require 'sinatra'
require 'json'
require_relative 'lib/matchings'

class App < Sinatra::Base
  get '/' do
    @exercise = Matchings::Impedance.new do |c|
      c.s11 = Complex.polar_grads(0.4, 162)
      c.s22 = Complex.polar_grads(0.35, -39)
      c.s12 = Complex.polar_grads(0.04, 60)
      c.s21 = Complex.polar_grads(5.2, 63)
    end
    erb :index
  end

  get '/parcial' do
    @exercise = Matchings::Impedance.new do |c|
      c.s11 = Complex.polar_grads(0.61, 165)
      c.s21 = Complex.polar_grads(3.72, 59)
      c.s12 = Complex.polar_grads(0.05, 42)
      c.s22 = Complex.polar_grads(0.45, -48)
    end
    erb :index
  end
end
