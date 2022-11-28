# frozen_string_literal: true

# This class - controller for work with pages input and show
class RootController < ApplicationController
  before_action :check, only: [:show]
  def input 
  end

  def show
    generate_arr
  end

  private

  def check
    @arr = []
    @number = params[:query].to_i
    @error = false
    @error = true unless params[:query].match?(/^[1-9]\d*$/)
  end

  def find(value)
    arr = [1]
    (2..value**0.5).each do |i|
      if (value % i).zero?
        arr << i
        arr << value / i unless i == value / i
      end
    end
    arr
  end

  def generate_arr
    @arr = (1..@number).map { |i| [i, find(i).sum] }
                       .select { |val, sum| sum <= @number && val != sum && val == find(sum).sum }
                       .uniq(&:min)
  end
end