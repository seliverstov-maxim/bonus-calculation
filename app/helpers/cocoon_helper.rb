module CocoonHelper
  #NOTICE: Virtus and Cocoon are conflicted by default
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
      new_object = association.to_s.classify.constantize.new
      new_object = wrap_object.call(new_object) if wrap_object.respond_to?(:call)

      html_options[:'data-association-insertion-template'] = CGI.escapeHTML(render_association(association, f, new_object, form_parameter_name, render_options, override_partial).to_str).html_safe

      html_options[:'data-count'] = count if count > 0

      link_to(name, '#', html_options)
    end
  end
end
