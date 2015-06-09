class SalesBonus
  #NOTICE: Модель выполняет 2 роли считает и для аутстафа и для продаж
  #NOTICE: Поэтому она такая раздутая. Надо зарефакторить будет
  include VirtusBase

  attribute :result, Integer
  attribute :contragent, String
  attribute :bonus_type, String
  attribute :prepayment_percent, Integer
  attribute :mulct_type, String

  attribute :sum, Integer
  attribute :first_sale, Boolean

  attribute :month_count, Integer
  attribute :monthly_income, Integer
  attribute :special_bonus, Integer

  def calc
    if ['outstaff_ruby', 'outstaff_markup', 'outstaff_development'].include? bonus_type
      @result = calc_by_outstaff_formula
    end
    @result = calc_by_base_formula
  end

  def calc_by_base_formula
    sum * (base_percent + percent_for_first_sale) / 100 * prepayment_coefficient * mulct_coefficient
  end

  def calc_by_outstaff_formula
    monthly_income * (base_percent + special_bonus) / 100 * prepayment_coefficient * (1 + 0.3 * (month_count - 1))
  end

  private

  def prepayment_coefficient
    return 1 unless prepayment_percent

    i = prepayment_coefficients.index{|e| e[:from].to_f <= prepayment_percent.to_f && e[:to].to_f >= prepayment_percent.to_f}
    return prepayment_coefficients[i][:coefficient].to_f if i
    1
  end

  def mulct_coefficient
    return mulct_coefficients[mulct_type.to_sym] if mulct_coefficients.keys.include?(mulct_type.to_sym)
    1
  end

  def percent_for_first_sale
    return configs.fetch(:percent_for_first_sale) if first_sale
    0
  end

  def prepayment_coefficients
    configs.fetch(:prepayment_coefficients, {})
  end

  def mulct_coefficients
    configs.fetch(:mulct_coefficients, {})
  end

  def base_percent
    configs.fetch(:base_percent, 0)
  end

  def configs
    CustomConfigs.by_type(bonus_type.to_sym)
  end
end
