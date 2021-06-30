# frozen_string_literal: true

# Entrypoint

$LOAD_PATH.unshift(File.dirname(__FILE__), 'lib')
require 'carty_calc'

begin
  CartyCalc.new(ARGV[0], ARGV[1]).calculate
rescue StandardError => e
  p "Error: #{e.class} #{e.message}"
end
