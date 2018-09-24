class Shopping < ApplicationRecord
  belongs_to :beneficiary
  belongs_to :provider
end
