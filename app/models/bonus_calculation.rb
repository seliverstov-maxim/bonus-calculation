class BonusCalculation
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion
  include Virtus.model

  attribute :bonuses, Array[Bonus]

  def persisted?
    false
  end
end
