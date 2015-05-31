$(function() {
  var outstaff_keys = ['outstaff_ruby', 'outstaff_markup', 'outstaff_development'];
  var other_keys = ['ds_development', 'ds_design', 'ds_support', 'ds_seo', 'ds_development_for_perspective_customer', 'p_development', 'p_design', 'p_support', 'p_seo'];
  var pm_keys = ['pm_ahead_of_schedule', 'pm_in_time', 'pm_delayed_by_2_weeks_fault_customer', 'pm_delayed_by_2_weeks_fault_company', 'pm_delayed_by_4_weeks_fault_company'];

  var fields_shown_for_outstaff = ['prepayment_percent', 'monthly_income', 'month_count', 'special_bonus'];
  var fields_shown_for_other = ['sum', 'prepayment_percent', 'first_sale', 'mulct_type'];
  var fields_shown_for_pm = ['sum', 'verbal_complaints', 'written_complaints', 'letters_of_thanks'];

  var hide_block = function(fields, name) { $(fields).find('.bonus_calculation_bonuses_' + name).css('display', 'none') }
  var show_block = function(fields, name) { $(fields).find('.bonus_calculation_bonuses_' + name).css('display', 'inline-block') }

  var hide_autstaff_blocks = function(fields) { $.each(fields_shown_for_outstaff, function(i, block_name) { hide_block(fields, block_name) }); }
  var show_autstaff_blocks = function(fields) { $.each(fields_shown_for_outstaff, function(i, block_name) { show_block(fields, block_name) }); }

  var hide_other_blocks = function(fields) { $.each(fields_shown_for_other, function(i, block_name) { hide_block(fields, block_name) }); }
  var show_other_blocks = function(fields) { $.each(fields_shown_for_other, function(i, block_name) { show_block(fields, block_name) }); }

  var hide_pm_blocks = function(fields) { $.each(fields_shown_for_pm, function(i, block_name) { hide_block(fields, block_name) }); }
  var show_pm_blocks = function(fields) { $.each(fields_shown_for_pm, function(i, block_name) { show_block(fields, block_name) }); }

  var checked_autstaff_bonus_type = function(type) { return ($.inArray(type, outstaff_keys) !== -1) }
  var checked_other_bonus_type = function(type) { return ($.inArray(type, other_keys) !== -1) }
  var checked_pm_bonus_type = function(type) { return ($.inArray(type, pm_keys) !== -1) }

  var update_visibility_by_bonus_type = function(selected_type, fields) {
    hide_autstaff_blocks(fields);
    hide_other_blocks(fields);
    hide_pm_blocks(fields);

    if(checked_autstaff_bonus_type(selected_type)) { show_autstaff_blocks(fields); }
    if(checked_other_bonus_type(selected_type)) { show_other_blocks(fields); }
    if(checked_pm_bonus_type(selected_type)) { show_pm_blocks(fields); }
  }

  var update_each_nested_field = function() {
    $('#new_bonus_calculation .bonus_calculation_bonuses_bonus_type select').each(function(i, e) {
      update_visibility_by_bonus_type(e.value, $(e).parents('.nested-fields')[0]);
    })
  }

  $('#new_bonus_calculation .bonus_calculation_bonuses_bonus_type select').change(function(e) {
    update_each_nested_field();
  });

  update_each_nested_field();

  $(document).bind('cocoon:after-insert', function(e,inserted_item) {
    $('#new_bonus_calculation .bonus_calculation_bonuses_bonus_type select').unbind();
    $('#new_bonus_calculation .bonus_calculation_bonuses_bonus_type select').change(
      function(e) {
        update_each_nested_field();
      }
    );
    update_each_nested_field();
  });
});