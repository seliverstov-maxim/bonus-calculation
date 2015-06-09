module ApplicationHelper

  def mulct_type_collection
    %w[
      no_contract
      no_latter
      no_prepayment
    ].each_with_object({}) do |key, obj|
      translate = t key
      obj[translate] = key
    end
  end

  def sales_bonus_type_collection
    %w[
      ds_development
      ds_design
      ds_support
      ds_seo
      ds_development_for_perspective_customer
      p_development
      p_design
      p_support
      p_seo
      outsource_development
      outstaff_ruby
      outstaff_markup
      outstaff_development
    ].each_with_object({}) do |key, obj|
      translate = t key
      obj[translate] = key
    end
  end

  def pm_bonus_type_collection
    %w[
      pm_ahead_of_schedule
      pm_in_time
      pm_delayed_by_2_weeks_fault_customer
      pm_delayed_by_2_weeks_fault_company
      pm_delayed_by_4_weeks_fault_company
    ].each_with_object({}) do |key, obj|
      translate = t key
      obj[translate] = key
    end
  end

  def detect_calc_strategy(bonus_type)
    return OutstaffFormula if ['outstaff_ruby', 'outstaff_markup', 'outstaff_development'].include? bonus_type
    return PmFormula if %w[pm_ahead_of_schedule pm_in_time pm_delayed_by_2_weeks_fault_customer pm_delayed_by_2_weeks_fault_company pm_delayed_by_4_weeks_fault_company].include? bonus_type
    BaseFormula
  end
end
