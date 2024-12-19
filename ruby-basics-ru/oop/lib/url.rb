# frozen_string_literal: true

require 'forwardable'
require 'uri'
# BEGIN
class Url
  extend Forwardable
  include Comparable

  def initialize(params)
    @url = URI(params)
  end

  def_delegators :@url, :scheme, :host, :port
  def_delegator :@url, :query

  def query_params
    return {} if query.nil?

    URI.decode_www_form(query).to_h.transform_keys(&:to_sym)
    # Hash[URI.decode_www_form(self.query).map{ |elem| [elem[0].to_sym] }]
  end

  def query_param(key, value = nil)
    query_params[key] || query_params[key.to_s] || value
  end

  def <=>(other)
    [scheme, host, port, query_params] <=> [other.scheme, other.host, other.port, other.query_params]
    # self.scheme <=> other.scheme && \
    # self.host <=> other.host && \
    # self.port <=> other.port && \
    # self.query_params <=> other.query_params
  end

  # def !=(other)
  #   !(self<=> other)
  # end
end
# END
