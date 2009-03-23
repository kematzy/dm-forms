# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-forms}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["TJ Holowaychuk"]
  s.date = %q{2009-03-23}
  s.description = %q{DataMapper model form generation}
  s.email = %q{tj@vision-media.ca}
  s.extra_rdoc_files = ["lib/dm-forms/base.rb", "lib/dm-forms/core_ext.rb", "lib/dm-forms/helpers.rb", "lib/dm-forms/mixins/descriptions.rb", "lib/dm-forms/mixins/errors.rb", "lib/dm-forms/mixins/labels.rb", "lib/dm-forms/mixins/wrappers.rb", "lib/dm-forms/mixins.rb", "lib/dm-forms/tag.rb", "lib/dm-forms/version.rb", "lib/dm-forms.rb", "README.rdoc", "tasks/benchmarks.rake", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake"]
  s.files = ["dm-forms.gemspec", "examples/benchmarks.rb", "examples/login.rb", "History.rdoc", "lib/dm-forms/base.rb", "lib/dm-forms/core_ext.rb", "lib/dm-forms/helpers.rb", "lib/dm-forms/mixins/descriptions.rb", "lib/dm-forms/mixins/errors.rb", "lib/dm-forms/mixins/labels.rb", "lib/dm-forms/mixins/wrappers.rb", "lib/dm-forms/mixins.rb", "lib/dm-forms/tag.rb", "lib/dm-forms/version.rb", "lib/dm-forms.rb", "Manifest", "Rakefile", "README.rdoc", "spec/functional/helpers_spec.rb", "spec/functional/mixins/descriptions_spec.rb", "spec/functional/mixins/labels_spec.rb", "spec/functional/mixins/wrappers_spec.rb", "spec/functional/tag_spec.rb", "spec/integration/datamapper_spec.rb", "spec/spec_helper.rb", "tasks/benchmarks.rake", "tasks/docs.rake", "tasks/gemspec.rake", "tasks/spec.rake", "Todo.rdoc"]
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
      s.add_runtime_dependency(%q<visionmedia-rext>, [">= 0"])
      s.add_development_dependency(%q<rspec_hpricot_matchers>, [">= 0"])
    else
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<visionmedia-rext>, [">= 0"])
      s.add_dependency(%q<rspec_hpricot_matchers>, [">= 0"])
    end
  else
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<visionmedia-rext>, [">= 0"])
    s.add_dependency(%q<rspec_hpricot_matchers>, [">= 0"])
  end
end
