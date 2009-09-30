# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{routengn}
  s.version = "0.27"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Keith Larrimore"]
  s.date = %q{2009-09-30}
  s.description = %q{RouteNGN is an Advanced SIP Redirect Routing Platform.}
  s.email = %q{keithlarrimore+github@gmail.com}
  s.files = ["script", "script/console", "routengn.gemspec", "examples", "examples/provision.rb", "examples/cli.rb", "README.rdoc", "bin", "bin/ngncmd", "lib", "lib/routengn.rb", "lib/routengn", "lib/routengn/mapper.rb", "lib/routengn/console.rb", "lib/routengn/models", "lib/routengn/models/locale.rb", "lib/routengn/models/endpoint.rb", "lib/routengn/models/record.rb", "lib/routengn/models/instance.rb", "lib/routengn/models/route.rb", "lib/routengn/models/rate.rb", "lib/routengn/models/region.rb", "lib/routengn/models/type.rb", "lib/routengn/models/dialcode.rb", "lib/routengn/models/group.rb", "lib/routengn/models/carrier.rb", "lib/routengn/http", "lib/routengn/http/multipart.rb", "lib/routengn/uploader.rb"] 
  s.has_rdoc = false
  s.homepage = %q{http://github.com/mojombo/grit}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{RouteNGN is an Advanced SIP Redirect Routing Platform.}
  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mime-types>, [">= 1.15"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 1.1.2"])
    else
      s.add_dependency(%q<mime-types>, [">= 1.15"])
      s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
    end
  else
    s.add_dependency(%q<mime-types>, [">= 1.15"])
    s.add_dependency(%q<diff-lcs>, [">= 1.1.2"])
  end
end

