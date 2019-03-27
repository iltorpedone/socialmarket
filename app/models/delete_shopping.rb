class DeleteShopping
  include Mu

  attr_accessor :shopping
  def initialize(shopping:)
    self.shopping = shopping
  end

  def self.call(shopping:)
    new(shopping: shopping).perform
  end

  def perform
    beneficiary = shopping.beneficiary
    SLACK_NOTIFIER.notify("[Cancellazione spesa][id:#{shopping_id}] INIZIO")
    build_data.then do |data|
      if shopping.hard_closed?
        SLACK_NOTIFIER.notify("[Cancellazione spesa][id:#{shopping_id}][spesa chiusa permanentemente]")
        new_shopping_points = beneficiary.shopping_points + data[:point_rank]
        SLACK_NOTIFIER.notify("[Cancellazione spesa][id:#{shopping_id}][punti spesa correnti beneficiario:#{beneficiary.shopping_points}][punti spesa da sommare:#{data[:point_rank]}][somma:#{new_shopping_points}]")
        beneficiary.update_columns(shopping_points: new_shopping_points)
      end
      data[:items].each do |item|
        db_item = WarehouseItem.find(item['warehouse_item_id'])
        new_quantity = db_item.stock_count + item['quantity']
        db_item.update_columns(stock_count: new_quantity)
      end
    end
    shopping.items.delete_all
    shopping.delete
    SLACK_NOTIFIER.notify("[Cancellazione spesa][id:#{shopping_id}] FINE")
    Result.success
  end

  def build_data
    if shopping.hard_closed?
      deserialized_data = JSON.parse(shopping.serialized_data)
      {
        point_rank: deserialized_data['point_rank'],
        items: deserialized_data['items'].map do |item|
          item.slice('quantity', 'warehouse_item_id')
        end,
      }
    else
      {
        items: shopping.items.map do |item|
          item.slice('quantity', 'warehouse_item_id')
        end,
      }
    end
  end
end
