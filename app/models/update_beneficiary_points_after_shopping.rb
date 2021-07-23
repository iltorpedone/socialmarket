module UpdateBeneficiaryPointsAfterShopping
  include Mu

  def self.call(beneficiary:)
    if beneficiary.shopping_points < beneficiary.point_rank
      return Result.error.code!(:not_enough_points)
    end
    value = beneficiary.shopping_points - beneficiary.point_rank
    SLACK_NOTIFIER.notify([
      "[Aggiornamento punti spesa]",
      "[beneficiario ID:#{beneficiary.id}]",
      "[punti spesa:#{beneficiary.shopping_points}]",
      "[P:#{beneficiary.point_rank}]",
      "[nuovi punti spesa:#{value}]"
    ].join)
    result = beneficiary.update(shopping_points: value)
    unless result
      SLACK_NOTIFIER.notify("[Aggiornamento punti spesa][Errore:#{result.inspect}]")
      return Result.error.code!(:cant_save_db_record)
    end

    Result.success
  end
end
