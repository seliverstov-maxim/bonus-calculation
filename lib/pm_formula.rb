module PmFormula
  def self.calc(params)
    # p "#{params[:sum].to_f} * (#{params[:base_percent].to_f} + #{params[:deadline_percent].to_f}) / 100 + #{params[:mulct_or_thanks_bonus].to_f}"
    (params[:sum].to_f - params[:spent].to_f) * (params[:base_percent].to_f + params[:deadline_percent].to_f) / 100 + params[:mulct_or_thanks_bonus].to_f
  end
end
