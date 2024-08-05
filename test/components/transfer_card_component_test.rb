# frozen_string_literal: true

require 'test_helper'

class TransferCardComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    transfer = FactoryBot.create(:transfer, :pending)
    render_inline(TransferCardComponent.new(transfer:))

    assert_text 'Pending'
    assert_text transfer.amount
    assert_text transfer.id
  end
end
