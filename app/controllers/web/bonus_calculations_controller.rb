class Web::BonusCalculationsController < Web::ApplicationController
  def edit
    @form = BonusCalculationForm.new(BonusCalculation.new({bonuses: [Bonus.new(sum: 200), Bonus.new()]}))
  end

  def create
    attrs = params[:bonus_calculation][:bonuses_attributes].values
    valid_bonuses = attrs.map{|e| Bonus.new(e) }.select{|e| BonusContract.new(e).validate }
    valid_bonuses.each do |b|
      result = ::CalcService.calc({
        calc_strategy: detect_calc_strategy(b.sales_type),
        formula_params: CalcParamsBuilder.build_for(b.sales_type, b.attributes)
      })
      b.result = (result == 0) ? nil : result
    end
    @form = BonusCalculationForm.new(BonusCalculation.new({bonuses: valid_bonuses}))
  end
end
