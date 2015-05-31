$(function() {
  var outstaff_keys = ['outstaff_ruby', 'outstaff_markup', 'outstaff_development'];
  var other_keys = ['ds_development', 'ds_design', 'ds_support', 'ds_seo', 'ds_development_for_perspective_customer', 'p_development', 'p_design', 'p_support', 'p_seo'];

  var fields_shown_for_outstaff = ['monthly_income', 'month_count', 'special_bonus'];
  var fields_shown_for_other = ['first_sale', 'sum', 'mulct_type'];

  var hide_block = function(fields, name) { $(fields).find('.bonus_calculation_bonuses_' + name).css('display', 'none') }
  var show_block = function(fields, name) { $(fields).find('.bonus_calculation_bonuses_' + name).css('display', 'inline-block') }

  var hide_autstaff_blocks = function(fields) { $.each(fields_shown_for_outstaff, function(i, block_name) { hide_block(fields, block_name) }); }
  var show_autstaff_blocks = function(fields) { $.each(fields_shown_for_outstaff, function(i, block_name) { show_block(fields, block_name) }); }

  var hide_other_blocks = function(fields) { $.each(fields_shown_for_other, function(i, block_name) { hide_block(fields, block_name) }); }
  var show_other_blocks = function(fields) { $.each(fields_shown_for_other, function(i, block_name) { show_block(fields, block_name) }); }

  var if_checked_autstaff_sales_type = function(type) { return ($.inArray(type, outstaff_keys) !== -1) }
  var if_checked_other_sales_type = function(type) { return ($.inArray(type, other_keys) !== -1) }

  var update_visibility_by_sales_type = function(type, fields) {
    if(if_checked_autstaff_sales_type(type)) {
      show_autstaff_blocks(fields);
      hide_other_blocks(fields);
      return;
    }
    if(if_checked_other_sales_type(type)) {
      show_other_blocks(fields);
      hide_autstaff_blocks(fields);
      return;
    }

    hide_autstaff_blocks(fields);
    hide_other_blocks(fields);
  }

  var update_each_nested_field = function() {
    $('#new_bonus_calculation .bonus_calculation_bonuses_sales_type select').each(function(i, e) {
      update_visibility_by_sales_type(e.value, $(e).parents('.nested-fields')[0]);
    })
  }

  $('#new_bonus_calculation .bonus_calculation_bonuses_sales_type select').change(function(e) {
    // update_visibility_by_sales_type(e.target.value, $(e.target).parents('.nested-fields')[0]);
    update_each_nested_field();
  });

  update_each_nested_field();

  $(document).bind('cocoon:after-insert', function(e,inserted_item) {
    $('#new_bonus_calculation .bonus_calculation_bonuses_sales_type select').unbind();
    $('#new_bonus_calculation .bonus_calculation_bonuses_sales_type select').change(
      function(e) {
        update_each_nested_field();
      }
    );
    update_each_nested_field();
  });
});