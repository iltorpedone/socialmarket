module CloseShopping
  def self.call(shopping_id)
    shopping = Shopping.find(shopping_id)
    result = UpdateBeneficiaryPointsAfterShopping.call(shopping: shopping)
    return result if result.error?

    presenter = ShoppingPresenter.new(shopping)
    data = {
      items: shopping.items.map do |item|
        {
          quantity: item.quantity,
          price: item.price,
          category_name: item.category_name,
          name: item.name,
        }
      end,
      price: presenter.price,
      quantity: presenter.quantity,
      items_count: presenter.items_count,
      beneficiary: presenter.beneficiary,
      provider: presenter.provider,
    }
    result = shopping.update(serialized_data: data.to_json)
    return Result.error.code!(:cant_save_to_database) unless result

    shopping.items.delete_all

    Result.success
  end
end
