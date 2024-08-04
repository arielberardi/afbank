# frozen_string_literal: true

class TransferCardComponent < ViewComponent::Base
  attr_reader :transfer

  STATUS_IMAGES = {
    'pending' => { image: 'pending.svg', class: 'bg-info' },
    'completed' => { image: 'completed.svg', class: '' },
    'failed' => { image: 'failed.svg', class: 'bg-danger' }
  }.freeze

  def initialize(transfer:)
    @transfer = transfer
    @image = STATUS_IMAGES[@transfer.status]
    @number = I18n.t('views.transfer.show.title', number: @transfer.id)
    @status = I18n.t("activerecord.attributes.transfer.status.#{@transfer.status}")
    @date = @transfer.created_at.strftime('%a %b %Y - %H:%M')
  end
end
