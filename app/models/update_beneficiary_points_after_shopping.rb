module UpdateBeneficiaryPointsAfterShopping
  def self.call(shopping:)
    beneficiary = shopping.beneficiary
    current = beneficiary.shopping_points
    return Result.error.code!(:not_enough_points) if current < shopping.total

    result = beneficiary.update(shopping_points: current - shopping.total)
    return Result.error.code!(:cant_save_db_record) unless result

    Result.success
  end
end
