module CloseShopping
  def self.call(shopping_id:)
    SLACK_NOTIFIER.notify("[Chiusura spesa][id:#{shopping_id}] INIZIO")
    shopping = Shopping.find(shopping_id)
    beneficiary = shopping.beneficiary
    old_shopping_points = beneficiary.shopping_points
    result = UpdateBeneficiaryPointsAfterShopping.call(beneficiary: beneficiary)
    if result.error?
      SLACK_NOTIFIER.notify("[Chiusura spesa][id:#{shopping_id}][Errore:#{result.code}]")
      shopping.beneficiary.update(shopping_points: old_shopping_points)
      return result
    end

    presenter = ShoppingPresenter.new(shopping)
    data = {
      items: shopping.items.map do |item|
        {
          quantity: item.quantity,
          price: item.price,
          category_name: item.category_name,
          name: item.name,
          warehouse_item_id: item.warehouse_item_id,
        }
      end,
      point_rank: presenter.beneficiary.point_rank.to_i,
      price: presenter.price,
      quantity: presenter.quantity,
      items_count: presenter.items_count,
      beneficiary: presenter.beneficiary,
      provider: presenter.provider,
    }
    result = shopping.update(
      status: :hard_closed,
      serialized_data: data.to_json,
    )
    unless result
      Rollbar.error(
        'Close Shopping',
        shopping_id: shopping_id,
        code: :cant_save_to_database,
      )
      SLACK_NOTIFIER.notify("[Chiusura spesa][id:#{shopping_id}][Errore:can't save to database]")
      return Result.error.code!(:cant_save_to_database)
    end

    shopping.items.delete_all
    SLACK_NOTIFIER.notify("[Chiusura spesa][id:#{shopping_id}][Successo] FINE")
    Result.success
  end
end
