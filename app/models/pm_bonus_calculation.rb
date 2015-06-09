class PmBonusCalculation
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion
  include Virtus.model

  attribute :pm_bonuses, Array[PmBonus]

  def persisted?
    false
  end
end
