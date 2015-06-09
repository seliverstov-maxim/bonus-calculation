class SalesBonus
  include VirtusBase

  attribute :result, Integer
  attribute :bonus_type, String
  attribute :prepayment_percent, Integer
  attribute :mulct_type, String

  attribute :sum, Integer
  attribute :first_sale, Boolean

  attribute :month_count, Integer
  attribute :monthly_income, Integer
  attribute :special_bonus, Integer
end
