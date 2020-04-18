# frozen_string_literal: true

require 'sinatra'
require 'json'
require_relative 'lib/matchings'

class App < Sinatra::Base
  get '/' do
    @s11 = Complex.polar_grads(0.4, 162)
    @s22 = Complex.polar_grads(0.35, -39)
    @s12 = Complex.polar_grads(0.04, 60)
    @s21 = Complex.polar_grads(5.2, 63)
    @matching = Matchings::Impedance.new(s11: @s11, s12: @s12, s21: @s21, s22: @s22)
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
