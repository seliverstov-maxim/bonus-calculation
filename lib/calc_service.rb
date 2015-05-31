module CalcService
  def self.calc(params)
    params[:calc_strategy].calc(params[:formula_params])
  end
end


