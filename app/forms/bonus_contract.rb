class BonusContract < Reform::Contract
  property :sales_type
  validates :sales_type, presence: true
end