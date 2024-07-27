module ApplicationHelper
  def currency_to_symbol(currency)
    currency_to_symbol_map = {
      'USD' => '$',
      'EUR' => '€',
      'GBP' => '£',
      'JPY' => '¥'
    }

    currency_to_symbol_map[currency.upcase]
  end
end
