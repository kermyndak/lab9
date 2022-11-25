class RootController < ApplicationController
  def input
  end

  def show
    unless params[:query].match?(/^[1-9]\d*$/)
      redirect_to root_path, notice = 'Bad input...'
    end
    @arr = []
    @number = params[:query].to_i
    generate_arr
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
    (1..@number).each do |n|
      (1..@number).each do |i|
        @arr << [n, i].sort if find(n).sum == i && find(i).sum == n && !@arr.include?([n, i].sort)
      end
    end
  end
end
