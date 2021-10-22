module ValidateShoppingTotal
  include Mu

  def self.call(point_rank:, total:)
    return Result.success if range(point_rank: point_rank).include?(total)
    Result.error
  end

  def self.range(point_rank:)
    Range.new(
      lower_bound(point_rank: point_rank),
      upper_bound(point_rank: point_rank),
    )
  end

  def self.lower_bound(point_rank:)
    point_rank
  end

  def self.upper_bound(point_rank:)
    point_rank + 3
  end
end
