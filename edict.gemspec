Gem::Specification.new do |spec|
  spec.name		= "edict"
  #{MAJOR: incompatible}.{MINOR added feature}.{PATCH bugfix}-{LABEL}
  spec.version		= "0.0.2"
  author_list = {
    "Judson Lester" => "judson@lrdesign.com",
    "Patricia Ho" => "patricia@lrdesign.com"
  }
  spec.authors		= author_list.keys
  spec.email		= spec.authors.map {|name| author_list[name]}
  spec.summary		= "Simple configurable tasks"
  spec.description	= <<-EndDescription
    Simple configurable tasks to make things do other things as a rule.
  EndDescription

  spec.rubyforge_project= spec.name.downcase
  spec.homepage        = "https://github.com/nyarly/edict"
  spec.required_rubygems_version = Gem::Requirement.new(">= 0") if spec.respond_to? :required_rubygems_version=

  # Do this: y$@"
  # !!find lib bin doc spec spec_help -not -regex '.*\.sw.' -type f 2>/dev/null
  spec.files		= %w[
    lib/edict.rb
    lib/edict/rule.rb
    lib/edict/command.rb
    lib/edict/ssh-command.rb
    spec/edict/command_spec.rb
    spec/edict/ssh-command_spec.rb
  ]

  spec.test_file        = "spec_help/gem_test_suite.rb"
  spec.licenses = ["MIT"]
  spec.require_paths = %w[lib/]
  spec.rubygems_version = "1.3.5"

  spec.has_rdoc		= true
  spec.extra_rdoc_files = Dir.glob("doc/**/*")
  spec.rdoc_options	= %w{--inline-source }
  spec.rdoc_options	+= %w{--main doc/README }
  spec.rdoc_options	+= ["--title", "#{spec.name}-#{spec.version} Documentation"]

  spec.add_dependency("calibrate", "> 0")

  #spec.post_install_message = "Thanks for installing my gem!"
end
