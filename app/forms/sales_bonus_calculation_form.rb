class SalesBonusCalculationForm < Reform::Form
  include Reform::Form::ModelReflections

  collection :sales_bonuses do
    property :result
    property :contragent
    property :bonus_type
    property :prepayment_percent
    property :mulct_type

    property :sum
    property :first_sale

    property :month_count
    property :monthly_income
    property :special_bonus
  end
end
