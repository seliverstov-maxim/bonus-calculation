class PmBonus
  include VirtusBase

  attribute :result, Integer
  attribute :contragent, String
  attribute :contract_number, String
  attribute :bonus_type, String
  attribute :sum, Integer
  attribute :spent, Integer
  attribute :rest, Integer
  attribute :verbal_complaints, Integer
  attribute :written_complaints, Integer
  attribute :letters_of_thanks, Boolean
end
