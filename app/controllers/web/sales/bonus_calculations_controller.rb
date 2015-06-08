class Web::Sales::BonusCalculationsController < Web::Sales::ApplicationController
  def new
    @form = SalesBonusCalculationForm.new(BonusCalculation.new({bonuses: [Bonus.new(), Bonus.new()]}))
  end

  def create
    attrs = params[:sales_bonus_calculation][:bonuses_attributes].values
    valid_bonuses = attrs.map{|e| Bonus.new(e) }.select{|e| BonusContract.new(e).validate }

    @total_result = 0

    valid_bonuses.each do |b|
      result = ::CalcService.calc({
        calc_strategy: detect_calc_strategy(b.bonus_type),
        formula_params: SalesCalcParamsBuilder.build_for(b.bonus_type, b.attributes)
      })
      b.result = (result == 0) ? nil : result
      @total_result += b.result
    end
    @form = SalesBonusCalculationForm.new(BonusCalculation.new({bonuses: valid_bonuses}))
  end
end
