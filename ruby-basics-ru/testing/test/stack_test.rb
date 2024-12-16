# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end

  def teardown; end

  def test_it_should_can_push
    @stack.push!(1)

    assert(@stack.size == 1)
  end

  def test_it_should_can_pop
    @stack.push!(1)
    @stack.pop!

    assert(@stack.size.empty?)
  end

  def test_is_should_have_size
    @stack.push!(1)
    @stack.push!(1)

    assert(@stack.size == 2)
  end

  def test_it_should_be_empty
    assert(@stack.empty?)
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
