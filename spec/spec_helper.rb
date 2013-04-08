require 'zemanta'
require 'webmock/rspec'

Zemanta.configure do |c|
  c.api_key = 'fake_key'
end
# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

def fixture(path)
  JSON.parse(File.read("spec/fixtures/zemanta/#{path}.json"))
end

def stub_zemanta_success!
  stub_request(:post, /api.zemanta.com/).
    to_return(:status => 200, :body => "{\"response\":\"zemanta_response\"}").times(1).then.
    to_return(:status => 404)
end

def stub_zemanta_full!
  stub_request(:post, /api.zemanta.com/).
    to_return(:status => 200, :body => {markup: fixture("markup")}.to_json)
end

def stub_zemanta_exception!
  stub_request(:post, /api.zemanta.com/).
    to_return(:status => 200, :body => '<h1>403 Developer Inactive</h1>')
end
