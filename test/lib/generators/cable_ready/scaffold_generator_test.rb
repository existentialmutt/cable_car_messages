require "test_helper"
require "generators/cable_ready/scaffold/scaffold_generator"

class CableReady::ScaffoldGeneratorTest < Rails::Generators::TestCase
  tests CableReady::ScaffoldGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
