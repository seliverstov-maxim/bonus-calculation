class PmBonusCalculationForm < Reform::Form
  include Reform::Form::ModelReflections

  collection :bonuses do
    property :result
    property :bonus_type
    property :sum

    property :verbal_complaints
    property :written_complaints
    property :letters_of_thanks
  end
end
