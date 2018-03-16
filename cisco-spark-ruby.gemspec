Gem::Specification.new do |s|
  s.name               = 'cisco-spark-ruby'
  s.version            = '0.0.3'
  s.default_executable = 'ciscospark'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['Robert Labrie']
  s.date = '2017-10-25'
  s.description = 'Cisco spark ruby early broken alpha use at your own risk'
  s.email = 'rolabrie@cisco.com'
  s.files = Dir['lib/*.rb'] + Dir['bin/*']
  # s.test_files = ["test/test_hola.rb"]
  # s.homepage = %q{http://rubygems.org/gems/hola}
  s.require_paths = %w[lib bin]
  s.bindir = 'bin'
  s.executables = ['ciscospark']
  s.rubygems_version = '1.6.2'
  s.summary = 'Cisco spark ruby - broken, under active development'

  if s.respond_to? :specification_version
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
    end
  end
end
