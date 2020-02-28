class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = get_api_client
    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name , last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.set_latest_prices(stocks)
    client = get_api_client
    stocks.each do |stock|
      stock.last_price = client.price(stock.ticker)
      stock.save
    end
  end

  private

  def self.get_api_client
    IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
  end

end
