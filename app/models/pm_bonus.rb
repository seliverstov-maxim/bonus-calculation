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

  def calc
    @rest = sum - spent

    @result = rest * (base_percent + deadline_percent) / 100 + mulct_or_thanks_bonus
  end

  private

  def base_percent
    configs[:base_percent].to_f
  end

  def deadline_percent
    return 0 unless deadline_bonus_coefficients
    deadline_bonus_coefficients[bonus_type.to_sym]
  end

  def mulct_or_thanks_bonus
    res = 0;
    res += verbal_complaints.to_f * configs[:verbal_complaints].to_f if verbal_complaints
    res += written_complaints.to_f * configs[:written_complaints].to_f if written_complaints
    res += configs[:letters_of_thanks].to_f if letters_of_thanks
    res
  end

  def deadline_bonus_coefficients
    configs.fetch(:deadline_bonus_coefficients, {})
  end

  def configs
    CustomConfigs.by_type(bonus_type.to_sym)
  end
end
