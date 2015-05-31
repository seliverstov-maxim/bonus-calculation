module OutstaffFormula
  def self.calc(params)
    params[:monthly_income].to_f * (params[:base_percent].to_f + params[:special_bonus].to_f) / 100 * params[:prepayment_coefficient].to_f * (1 + 0.3 * (params[:month_count].to_f - 1))
  end
end