class SalesController < ApplicationController

  def show
    @from = params[:from]
    @to = params[:to]

    if @from > @to
      render json: {
          error: "422"
      }, status: :unprocessable_entity
    else
      render json: get_data(@from, @to), status: :ok
    end
  end

  def get_data(from, to)
    @good = []
    @sale = Sale.where(date: (from..to)).joins(:good).select("goods.title AS good_title", :id, :income)
    @sum = @sale.sum(:income).round(2)
    @sale.group_by(&:good_title).each {|k, v|
      @good << {
          title: k,
          revenue: v.sum(&:income).round(2)
      }
    }

    return {
        from: from,
        to: to,
        good: @good,
        total_revenue: @sum
    }
  end

end
