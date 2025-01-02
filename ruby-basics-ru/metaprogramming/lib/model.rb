# frozen_string_literal: true

# BEGIN
module Model
  def initialize(params = {})
    @attributes = {}
    self.class.attr_options.each do |name, options|
      value = params.key?(name) ? params[name] : options.fetch(:default, nil)
      write_attribute(name, value)
    end
  end

  def write_attribute(name, value)
    options = self.class.attr_options[name]
    @attributes[name] = self.class.convert(value, options[:type])
  end

  def self.included(base)
    base.attr_reader :attributes
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attr_options
      @attr_options || {}
    end

    def attribute(name, options = {})
      @attr_options ||= {}
      @attr_options[name] = options

      define_method name do
        @attributes[name]
      end

      define_method "#{name}=" do |value|
        write_attribute(name, value)
      end
    end

    def convert(value, type)
      return value if value.nil?

      case type
      when :integer
        value.to_i
      when :string
        value.to_s
      when :boolean
        !!value
      when :datetime
        DateTime.parse(value)
      end
    end
  end
end
# END
