class Web::Pm::BonusCalculationsController < Web::Pm::ApplicationController
  def new
    @form = PmBonusCalculationForm.new(BonusCalculation.new({bonuses: [Bonus.new(), Bonus.new()]}))
  end

  def create
    attrs = params.fetch(:pm_bonus_calculation, {}).fetch(:bonuses_attributes, {}).values
    valid_bonuses = attrs.map{|e| Bonus.new(e) }.select{|e| BonusContract.new(e).validate }

    @total_result = 0

    valid_bonuses.each do |b|
      result = ::CalcService.calc({
        calc_strategy: detect_calc_strategy(b.bonus_type),
        formula_params: PmCalcParamsBuilder.build_for(b.bonus_type, b.attributes)
      })
      b.result = (result == 0) ? nil : result
      @total_result += b.result
    end
    @form = PmBonusCalculationForm.new(BonusCalculation.new({bonuses: valid_bonuses}))
  end
end
