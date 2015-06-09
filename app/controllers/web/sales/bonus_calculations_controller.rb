class Web::Sales::BonusCalculationsController < Web::Sales::ApplicationController
  def new
    bonus_calculation = SalesBonusCalculation.new({sales_bonuses: [SalesBonus.new()]})
    @form = SalesBonusCalculationForm.new(bonus_calculation)
  end

  def create
    attrs = params.fetch(:sales_bonus_calculation, {}).fetch(:sales_bonuses_attributes, {}).values
    valid_bonuses = attrs.map{|e| SalesBonus.new(e) }.select{|e| BonusContract.new(e).validate }

    @total_result = 0

    valid_bonuses.each do |b|
      result = ::CalcService.calc({
        calc_strategy: detect_calc_strategy(b.bonus_type),
        formula_params: SalesCalcParamsBuilder.build_for(b.bonus_type, b.attributes)
      })
      b.result = (result == 0) ? nil : result
      @total_result += result.to_i
    end
    @form = SalesBonusCalculationForm.new(SalesBonusCalculation.new({sales_bonuses: valid_bonuses}))
  end
end
