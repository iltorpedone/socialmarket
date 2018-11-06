class ShoppingPresenter
  def initialize(object)
    @object = object
  end

  def id
    @object.id
  end

  def quantity
    items.map(&:quantity).sum
  end

  def items
    @object.items
  end

  def items_count
    items.count
  end

  def price
    items.map(&:price).sum
  end

  def beneficiary
    @object.beneficiary
  end

  def provider
    @object.provider
  end
end
