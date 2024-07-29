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

  def image_for_transaction_status(status)
    configuration = {
      'pending' => { image: 'pending.svg', class: 'bg-info' },
      'completed' => { image: 'complete.svg', class: '' },
      'cancelled' => { image: 'cancelled.svg', class: '' },
      'failed' => { image: 'failed.svg', class: 'bg-danger' }
    }

    image_tag configuration[status][:image],
              class: "card-img-top #{configuration[status][:class]}",
              alt: "#{status.capitalize} status"
  end
end
