
require 'dm-forms/builder/base'

module DataMapper::Form::Builder
  autoload :Errors,       'dm-forms/builder/mixins/errors'
  autoload :Labels,       'dm-forms/builder/mixins/labels'
  autoload :Wrapper,      'dm-forms/builder/mixins/wrapper'
  autoload :Descriptions, 'dm-forms/builder/mixins/descriptions'
end

