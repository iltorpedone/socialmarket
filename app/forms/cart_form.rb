class CartForm
  attr_accessor :shopping_id, :user
  include ActiveModel::Model

  def shopping
    @shopping ||= Shopping.find(shopping_id)
  end

  def beneficiary
    shopping.beneficiary
  end
end
