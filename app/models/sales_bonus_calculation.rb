class SalesBonusCalculation
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion
  include Virtus.model

  attribute :sales_bonuses, Array[SalesBonus]

  def persisted?
    false
  end
end
