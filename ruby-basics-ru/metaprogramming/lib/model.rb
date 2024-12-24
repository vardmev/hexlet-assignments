# frozen_string_literal: true

# BEGIN
module Model
  def initialize(params = {})
    @id, @title, @body, @created_at, @published = params[:id], params[:title], params[:body], params[:created_at], params[:published]
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def attribute(name, options = {})
      define_method name do
        res = instance_variable_get "@#{name}"
        return if res.nil?

        if options[:type]
          res = case options[:type]
                when :integer
                  res.to_i
                when :string
                  res.to_s
                when :boolean
                  res
                when :datetime
                  DateTime.parse(res)
                end
        end

        res
      end

      define_method "#{name}=" do |value|
        instance_variable_set "@#{name}", value
      end
    end
  end

  def attributes
    { id: id, title: title, body: body, created_at: created_at, published: published }
  end
end
# END
