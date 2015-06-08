require 'yaml'

module PmCalcParamsBuilder
  @default_formulas_conf = ::YAML.load(File.read("config/default_params_for_formulas.yaml"))

  def self.build_for(bonus_type, custom_params = {})
    conf = @default_formulas_conf[:bonus_types][bonus_type.to_sym]
    res = {
      sum: custom_params[:sum],
      base_percent: conf[:base_percent],
      deadline_percent: deadline_percent(custom_params[:bonus_type], conf[:deadline_bonus_coefficients]),
      mulct_or_thanks_bonus: mulct_or_thanks_bonus(custom_params[:verbal_complaints], custom_params[:written_complaints], custom_params[:letters_of_thanks], conf)
    }
    res
  end

  def self.deadline_percent(bonus_type, deadline_bonus_coefficients)
    return 0 unless deadline_bonus_coefficients
    return deadline_bonus_coefficients[bonus_type.to_sym]
    0
  end

  def self.mulct_or_thanks_bonus(verbal_complaints, written_complaints, letters_of_thanks, coefficients)
    res = 0;
    res += verbal_complaints.to_f * coefficients[:verbal_complaints].to_f if verbal_complaints
    res += written_complaints.to_f * coefficients[:written_complaints.to_sym].to_f if written_complaints
    res += coefficients[:letters_of_thanks].to_f if letters_of_thanks
    res
  end
end
