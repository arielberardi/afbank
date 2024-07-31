module ApplicationHelper
  def money_with_currency(amount, currency)
    currency_symbol = {
      'USD' => '$',
      'EUR' => '€',
      'GBP' => '£'
    }

    "#{amount} #{currency_symbol[currency.upcase]}"
  end

  def active?(path)
    'active' if current_page?(path)
  end
end
