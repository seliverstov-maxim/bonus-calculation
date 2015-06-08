require 'yaml'

module SalesCalcParamsBuilder
  @default_formulas_conf = ::YAML.load(File.read("config/default_params_for_formulas.yaml"))

  def self.build_for(bonus_type, custom_params = {})
    conf = @default_formulas_conf[:bonus_types][bonus_type.to_sym]
    res = {
      percent_for_first_sale: percent_for_first_sale(custom_params[:first_sale], conf[:percent_for_first_sale]),
      sum: custom_params[:sum],
      base_percent: conf[:base_percent],
      prepayment_coefficient: prepayment_coefficient(custom_params[:prepayment_percent], conf[:prepayment_coefficients]),
      mulct_coefficient: mulct_coefficient(custom_params[:mulct_type], conf[:mulct_coefficients]),

      monthly_income: custom_params[:monthly_income],
      special_bonus: custom_params[:special_bonus],
      month_count: custom_params[:month_count]
    }
    res
  end

  def self.prepayment_coefficient(prepayment_percent, prepayment_coefficients)
    return 1 unless prepayment_coefficients && prepayment_percent

    i = prepayment_coefficients.index{|e| e[:from].to_f <= prepayment_percent.to_f && e[:to].to_f >= prepayment_percent.to_f}
    return prepayment_coefficients[i][:coefficient].to_f if i
    1
  end

  def self.mulct_coefficient(mulct_type, mulct_coefficients)
    return 1 unless mulct_coefficients

    return mulct_coefficients[mulct_type.to_sym] if mulct_coefficients.keys.include?(mulct_type.to_sym)
    1
  end

  def self.percent_for_first_sale(need_prepayment_coefficient, coefficient)
    return coefficient if need_prepayment_coefficient === true
    0
  end

end
