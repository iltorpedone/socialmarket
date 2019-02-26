module UpdateBeneficiaryPointsAfterShopping
  def self.call(shopping:)
    beneficiary = shopping.beneficiary
    if beneficiary.shopping_points < beneficiary.point_rank
      return Result.error.code!(:not_enough_points)
    end
    value = beneficiary.shopping_points - beneficiary.point_rank
    result = beneficiary.update(shopping_points: value)
    return Result.error.code!(:cant_save_db_record) unless result

    Result.success
  end
end
