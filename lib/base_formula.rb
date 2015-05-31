module BaseFormula
  def self.calc(params)
    params[:sum].to_f * (params[:base_percent].to_f + params[:percent_for_first_sale].to_f) / 100 * params[:prepayment_coefficient].to_f * params[:mulct_coefficient].to_f
  end
end