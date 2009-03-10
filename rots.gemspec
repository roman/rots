# -*- encoding: utf-8 -*-

require 'fileutils'

# Helper to retrieve the "revision number" of the git tree.
def git_tree_version
  #if File.directory?(".git")
  #  @tree_version ||= `git describe`.strip.sub('-', '.')
  #  @tree_version << ".0"  unless @tree_version.count('.') == 2
  #else
    $: << "lib"
    require 'ruby_openid_test_server'
    @tree_version = RubyOpenIdTestServer.release
  #end
  @tree_version
end

def gem_version
  git_tree_version.gsub(/-.*/, '')
end

def release
  "ruby-openid-tester-#{git_tree_version}"
end

def manifest
  `git ls-files`.split("\n")
end

Gem::Specification.new do |s|
  s.name            = "rots"
  s.version         = gem_version
  s.platform        = Gem::Platform::RUBY
  s.summary         = "an OpenID server for making tests of OpenID clients implementations"

  s.description = <<-EOF
Ruby OpenID Test Server (ROST) provides a basic OpenID server made in top of the Rack gem.
With this small server, you can make dummy OpenID request for testing purposes,
the success of the response will depend on a parameter given on the url of the authentication request.
  EOF

  s.files           = manifest
  s.bindir          = 'bin'
  s.executables     << 'rots'
  s.require_path    = 'lib'
  s.has_rdoc        = true
  s.extra_rdoc_files = ['README']
  s.test_files      = Dir['spec/*_spec.rb']

  s.author          = 'Roman Gonzalez'
  s.email           = 'romanandreg@gmail.com'
  s.homepage        = 'http://github.com/roman'
  s.rubyforge_project = 'rots'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rack'
  s.add_development_dependency 'ruby-openid', '~> 2.0.0'
end
