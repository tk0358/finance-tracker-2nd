class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search"
        format.js { render partial: 'users/result' }
      end
    end
  end

  def reflesh
    @tracked_stocks = current_user.stocks
    @user = current_user
    Stock.set_latest_prices(@tracked_stocks)
    
    respond_to do |format|
      format.js { render partial: 'stocks/list' }
    end
  end

  def one_stock_reflesh
    @stock = Stock.check_db(params[:ticker])
    @stock.set_latest_price
    @stock.save
    @index = params[:index]
    
    respond_to do |format|
      format.js { 
        render partial: 'stocks/price'
      }
    end
  end
end