module ApplicationHelper

  def mulct_type_collection
    %w[no_contract no_latter no_prepayment].each_with_object({}) do |key, obj|
      translate = t key
      obj[translate] = key
    end
  end

  def detect_calc_strategy(bonus_type)
    return OutstaffFormula if ['outstaff_ruby', 'outstaff_markup', 'outstaff_development'].include? bonus_type
    return PmFormula if %w[pm_ahead_of_schedule pm_in_time pm_delayed_by_2_weeks_fault_customer pm_delayed_by_2_weeks_fault_company pm_delayed_by_4_weeks_fault_company].include? bonus_type
    BaseFormula
  end

  def bonus_type_collection
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

  def bonus_link_to_add_association(*args, &block)
      if block_given?
        f            = args[0]
        association  = args[1]
        html_options = args[2] || {}
        link_to_add_association(capture(&block), f, association, html_options)
      else
        name         = args[0]
        f            = args[1]
        association  = args[2]
        html_options = args[3] || {}

        render_options   = html_options.delete(:render_options)
        render_options ||= {}
        override_partial = html_options.delete(:partial)
        wrap_object = html_options.delete(:wrap_object)
        force_non_association_create = html_options.delete(:force_non_association_create) || false
        form_parameter_name = html_options.delete(:form_name) || 'f'
        count = html_options.delete(:count).to_i

        html_options[:class] = [html_options[:class], "add_fields"].compact.join(' ')
        html_options[:'data-association'] = association.to_s.singularize
        html_options[:'data-associations'] = association.to_s.pluralize

        new_object = Bonus.new
        new_object = wrap_object.call(new_object) if wrap_object.respond_to?(:call)

        html_options[:'data-association-insertion-template'] = CGI.escapeHTML(render_association(association, f, new_object, form_parameter_name, render_options, override_partial).to_str).html_safe

        html_options[:'data-count'] = count if count > 0

        link_to(name, '#', html_options)
      end
    end
end
