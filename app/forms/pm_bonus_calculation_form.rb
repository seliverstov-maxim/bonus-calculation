class PmBonusCalculationForm < Reform::Form
  include Reform::Form::ModelReflections

  collection :pm_bonuses do
    property :result
    property :contragent
    property :contract_number
    property :bonus_type
    property :sum
    property :spent
    property :rest

    property :verbal_complaints
    property :written_complaints
    property :letters_of_thanks
  end
end
