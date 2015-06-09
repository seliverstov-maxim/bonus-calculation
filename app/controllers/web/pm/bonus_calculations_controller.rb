class Web::Pm::BonusCalculationsController < Web::Pm::ApplicationController
  def new
    bonus_calculation = PmBonusCalculation.new({pm_bonuses: [PmBonus.new()]})
    @form = PmBonusCalculationForm.new(bonus_calculation)
  end

  def create
    b_calc = PmBonusCalculation.new calc_bonus_attrs
    b_calc.pm_bonuses.each { |e| e.result = 0; e.calc if BonusContract.new(e).validate }

    @form = PmBonusCalculationForm.new(b_calc)
    @total_result = b_calc.pm_bonuses.reduce(0) { |sum, e| sum + e.result }
  end

  private

  def calc_bonus_attrs
    {
      pm_bonuses: params.fetch(:pm_bonus_calculation, {}).fetch(:pm_bonuses_attributes, {}).values
    }
  end
end
