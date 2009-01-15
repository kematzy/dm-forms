# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-forms}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["TJ Holowaychuk"]
  s.date = %q{2009-01-15}
  s.description = %q{DataMapper model form generation}
  s.email = %q{tj@vision-media.ca}
  s.extra_rdoc_files = ["README.rdoc", "lib/dm-forms.rb", "lib/dm-forms/core_ext.rb", "lib/dm-forms/elements.rb", "lib/dm-forms/model_elements.rb", "lib/dm-forms/tag.rb", "lib/dm-forms/version.rb", "tasks/benchmarks.rake", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake"]
  s.files = ["History.rdoc", "Manifest", "README.rdoc", "Rakefile", "Todo.rdoc", "examples/benchmarks.rb", "examples/datamapper.rb", "examples/elements.rb", "examples/haml.rb", "examples/login.haml", "lib/dm-forms.rb", "lib/dm-forms/core_ext.rb", "lib/dm-forms/elements.rb", "lib/dm-forms/model_elements.rb", "lib/dm-forms/tag.rb", "lib/dm-forms/version.rb", "spec/functional/core_ext_spec.rb", "spec/functional/elements_spec.rb", "spec/functional/tag_spec.rb", "spec/integration/datamapper_spec.rb", "spec/integration/haml_spec.rb", "spec/spec_helper.rb", "tasks/benchmarks.rake", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake", "dm-forms.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/visionmedia/dm-forms}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Dm-forms", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{dm-forms}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{DataMapper model form generation}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
      s.add_development_dependency(%q<rspec_hpricot_matchers>, [">= 0"])
    else
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<rspec_hpricot_matchers>, [">= 0"])
    end
  else
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<rspec_hpricot_matchers>, [">= 0"])
  end
end
