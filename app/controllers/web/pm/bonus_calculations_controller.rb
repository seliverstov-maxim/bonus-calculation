class Web::Pm::BonusCalculationsController < Web::Pm::ApplicationController
  def new
    bonus_calculation = PmBonusCalculation.new({pm_bonuses: [PmBonus.new()]})
    @form = PmBonusCalculationForm.new(bonus_calculation)
  end

  def create
    attrs = params.fetch(:pm_bonus_calculation, {}).fetch(:pm_bonuses_attributes, {}).values
    valid_bonuses = attrs.map{|e| PmBonus.new(e) }.select{|e| BonusContract.new(e).validate }

    @total_result = 0

    valid_bonuses.each do |b|
      result = ::CalcService.calc({
        calc_strategy: detect_calc_strategy(b.bonus_type),
        formula_params: PmCalcParamsBuilder.build_for(b.bonus_type, b.attributes)
      })
      b.result = (result == 0) ? nil : result
      @total_result += result.to_i
    end
    @form = PmBonusCalculationForm.new(PmBonusCalculation.new({pm_bonuses: valid_bonuses}))
  end
end
