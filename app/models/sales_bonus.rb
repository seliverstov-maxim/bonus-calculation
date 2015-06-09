class SalesBonus
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion
  include Virtus.model

  attribute :result, Integer
  attribute :bonus_type, String
  attribute :prepayment_percent, Integer
  attribute :mulct_type, String

  attribute :sum, Integer
  attribute :first_sale, Boolean

  attribute :month_count, Integer
  attribute :monthly_income, Integer
  attribute :special_bonus, Integer

  def persisted?
    false
  end

  def has_attribute?(attr_name)
    attributes.key? attr_name.to_sym
  end

  def column_for_attribute(name)
    name
  end
end
