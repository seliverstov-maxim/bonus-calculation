$(function() {
  var outstaff_keys = ['outstaff_ruby', 'outstaff_markup', 'outstaff_development'];
  var other_keys = ['ds_development', 'ds_design', 'ds_development_for_perspective_customer', 'p_development', 'p_design', 'outsource_development'];
  var seo_support_keys = ['ds_support', 'ds_seo', 'p_support', 'p_seo'];

  var fields_shown_for_outstaff = ['prepayment_percent', 'monthly_income', 'month_count', 'special_bonus'];
  var fields_shown_for_other = ['sum', 'prepayment_percent', 'first_sale', 'mulct_type'];
  var fields_shown_for_seo_support = ['sum', 'first_sale', 'mulct_type'];

  var hide_block = function(fields, name) { $(fields).find('.sales_bonus_calculation_sales_bonuses_' + name).css('display', 'none') }
  var show_block = function(fields, name) { $(fields).find('.sales_bonus_calculation_sales_bonuses_' + name).css('display', 'inline-block') }

  var hide_autstaff_blocks = function(fields) { $.each(fields_shown_for_outstaff, function(i, block_name) { hide_block(fields, block_name) }); }
  var show_autstaff_blocks = function(fields) { $.each(fields_shown_for_outstaff, function(i, block_name) { show_block(fields, block_name) }); }

  var hide_other_blocks = function(fields) { $.each(fields_shown_for_other, function(i, block_name) { hide_block(fields, block_name) }); }
  var show_other_blocks = function(fields) { $.each(fields_shown_for_other, function(i, block_name) { show_block(fields, block_name) }); }

  var hide_seo_support_blocks = function(fields) { $.each(fields_shown_for_seo_support, function(i, block_name) { hide_block(fields, block_name) }); }
  var show_seo_support_blocks = function(fields) { $.each(fields_shown_for_seo_support, function(i, block_name) { show_block(fields, block_name) }); }

  var checked_autstaff_bonus_type = function(type) { return ($.inArray(type, outstaff_keys) !== -1) }
  var checked_other_bonus_type = function(type) { return ($.inArray(type, other_keys) !== -1) }
  var checked_seo_support_bonus_type = function(type) { return ($.inArray(type, seo_support_keys) !== -1) }

  var update_visibility_by_bonus_type = function(selected_type, fields) {
    hide_autstaff_blocks(fields);
    hide_other_blocks(fields);
    hide_seo_support_blocks(fields);

    if(checked_autstaff_bonus_type(selected_type)) { show_autstaff_blocks(fields); }
    if(checked_other_bonus_type(selected_type)) { show_other_blocks(fields); }
    if(checked_seo_support_bonus_type(selected_type)) { show_seo_support_blocks(fields); }
  }

  var update_each_nested_field = function() {
    $('#new_sales_bonus_calculation .sales_bonus_calculation_sales_bonuses_bonus_type select').each(function(i, e) {
      update_visibility_by_bonus_type(e.value, $(e).parents('.nested-fields')[0]);
    })
  }

  $('#new_sales_bonus_calculation .sales_bonus_calculation_sales_bonuses_bonus_type select').change(function(e) {
    update_each_nested_field();
  });

  update_each_nested_field();

  $(document).bind('cocoon:after-insert', function(e,inserted_item) {
    $('#new_sales_bonus_calculation .sales_bonus_calculation_sales_bonuses_bonus_type select').unbind();
    $('#new_sales_bonus_calculation .sales_bonus_calculation_sales_bonuses_bonus_type select').change(
      function(e) {
        update_each_nested_field();
      }
    );
    update_each_nested_field();
  });
});
