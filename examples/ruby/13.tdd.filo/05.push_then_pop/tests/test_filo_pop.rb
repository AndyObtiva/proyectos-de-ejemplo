#!/usr/bin/ruby

require 'test/unit'
require_relative '../lib/filo'

class FiloPopTest < Test::Unit::TestCase

  def test_new_pop
    filo = Filo.new
    assert_equal nil, filo.pop
  end

  def test_push_1_element_and_pop_1_element
    filo = Filo.new
    filo.push(42)
    assert_equal 42, filo.pop
    assert_equal nil, filo.pop
  end

  def test_push_2_elements_and_pop_2_elements
    filo = Filo.new
    filo.push(42)
    filo.push(43)
    assert_equal 42, filo.pop
    assert_equal 43, filo.pop
    assert_equal nil, filo.pop
  end

  def test_push_10_elements_and_pop_10_elements
    filo = Filo.new
    ('a'..'i').each { |item| filo.push(item) }
    p filo
    assert_equal 'a', filo.pop
    filo.pop
    filo.pop
    filo.pop
    filo.pop
    filo.pop
    assert_equal 'g', filo.pop
    filo.pop
    assert_equal 'i', filo.pop
    assert_equal nil, filo.pop
    p filo
  end
end
