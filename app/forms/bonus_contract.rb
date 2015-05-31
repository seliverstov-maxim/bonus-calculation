class BonusContract < Reform::Contract
  property :bonus_type
  validates :bonus_type, presence: true
end