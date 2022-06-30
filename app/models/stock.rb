class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:publishable],
      secret_token: Rails.application.credentials.iex[:secret],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.get_price(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:publishable],
      secret_token: Rails.application.credentials.iex[:secret],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    price = client.price(ticker_symbol)
  end

  def self.check_db(ticker)
    stock = where(ticker: ticker).first
  end
end
