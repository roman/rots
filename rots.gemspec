# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rots/version"

Gem::Specification.new do |s|
  s.name            = "rots"
  s.version         = Rots::VERSION
  s.platform        = Gem::Platform::RUBY
  s.summary         = "an OpenID server for making tests of OpenID clients implementations"

  s.description = <<-EOF
Ruby OpenID Test Server (ROST) provides a basic OpenID server made in top of the Rack gem.
With this small server, you can make dummy OpenID request for testing purposes,
the success of the response will depend on a parameter given on the URL of the authentication request.
  EOF

  s.files           = ["AUTHORS", "README", "Rakefile", "bin/rots", "lib/rots.rb", "lib/rots/identity_page_app.rb", "lib/rots/server_app.rb", "lib/rots/test_helper.rb","rots.gemspec", "spec/server_app_spec.rb", "spec/spec_helper.rb"] 
  s.bindir          = 'bin'
  s.executables     << 'rots'
  s.require_path    = 'lib'
  s.has_rdoc        = true
  s.extra_rdoc_files = ['README']
  s.test_files      = ['spec/server_app_spec.rb', 'spec/spec_helper.rb']

  s.author          = 'Roman Gonzalez'
  s.email           = 'romanandreg@gmail.com'
  s.homepage        = 'http://github.com/roman'
  s.rubyforge_project = 'rots'
  s.license         = 'MIT'

  s.add_development_dependency 'rspec', "~> 2.14.1"
  s.add_development_dependency 'rack', "~> 1.5.2"
  s.add_development_dependency 'ruby-openid', "~> 2.3.0"
end
