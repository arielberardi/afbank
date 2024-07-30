# frozen_string_literal: true

class TransactionCardComponent < ViewComponent::Base
  attr_reader :transaction

  STATUS_IMAGES = {
    'pending' => { image: 'pending.svg', class: 'bg-info' },
    'completed' => { image: 'completed.svg', class: '' },
    'cancelled' => { image: 'cancelled.svg', class: '' },
    'failed' => { image: 'failed.svg', class: 'bg-danger' }
  }.freeze

  def initialize(transaction:)
    @transaction = transaction
    @image = STATUS_IMAGES[@transaction.status]
    @number = I18n.t('views.transaction.show.title', number: @transaction.id)
    @status = I18n.t("activerecord.attributes.transaction.status.#{@transaction.status}")
    @date = @transaction.created_at.strftime('%a %b %Y - %H:%M')
  end
end
