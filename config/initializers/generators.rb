Rails.application.config.generators do |g|
  g.stylesheets false
  g.template_engine :haml
  g.test_framework :rspec, :fixture_replacement => :factory_girl
  g.fixture_replacement :factory_girl, :dir => "test/factories"
end
