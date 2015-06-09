class Web::Sales::BonusCalculationsController < Web::Sales::ApplicationController
  def new
    bonus_calculation = SalesBonusCalculation.new({sales_bonuses: [SalesBonus.new()]})
    @form = SalesBonusCalculationForm.new(bonus_calculation)
  end

  def create
    b_calc = SalesBonusCalculation.new calc_bonus_attrs
    b_calc.sales_bonuses.each { |e| e.result = 0; e.calc if BonusContract.new(e).validate }

    @form = SalesBonusCalculationForm.new(b_calc)
    @total_result = b_calc.sales_bonuses.reduce(0) { |sum, e| sum + e.result }
  end

  private

  def calc_bonus_attrs
    {
      sales_bonuses: params.fetch(:sales_bonus_calculation, {}).fetch(:sales_bonuses_attributes, {}).values
    }
  end
end
