module VirtusBase
  extend ActiveSupport::Concern

  included do
    extend ActiveModel::Naming
    extend ActiveModel::Translation
    include ActiveModel::Conversion
    include Virtus.model

    def persisted?
      false
    end

    def has_attribute?(attr_name)
      attributes.key? attr_name.to_sym
    end

    def column_for_attribute(name)
      name
    end
  end
end
