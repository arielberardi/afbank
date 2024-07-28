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

  def account_type_i18n(type)
    I18n.t("activerecord.attributes.account.type.#{type.downcase}")
  end
end
