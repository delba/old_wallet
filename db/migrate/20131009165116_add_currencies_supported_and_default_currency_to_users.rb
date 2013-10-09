class AddCurrenciesSupportedAndDefaultCurrencyToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :currencies_supported
      t.string :default_currency
    end
  end
end
