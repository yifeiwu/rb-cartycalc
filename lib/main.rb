# frozen_string_literal: true

# Entrypoint

$LOAD_PATH.unshift(File.dirname(__FILE__), 'lib')
require 'carty_calc'

p CartyCalc.new(ARGV[0], ARGV[1]).calculate
