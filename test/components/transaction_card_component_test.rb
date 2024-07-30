# frozen_string_literal: true

require 'test_helper'

class TransactionCardComponentTest < ViewComponent::TestCase
  def test_component_renders_something_useful
    transaction = FactoryBot.create(:transaction, :pending)
    render_inline(TransactionCardComponent.new(transaction:))

    assert_text 'Pending'
    assert_text transaction.amount
    assert_text transaction.id
    assert_text transaction.recipient
  end
end
