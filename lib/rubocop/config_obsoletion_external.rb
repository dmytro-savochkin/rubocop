# frozen_string_literal: true

module RuboCop
  # This class handles deprecated config entries defined in external gems. It correctly assigns
  # them a new (deep) department name.
  class ConfigObsoletionExternal
    DEPRECATED_EXTERNAL_COPS = {
      'rubocop-rspec' => {
        'FactoryBot' => 'RSpec/FactoryBot',
        'Capybara' => 'RSpec/Capybara',
        'Capybara/CurrentPathExpectation' => 'RSpec/Capybara/CurrentPathExpectation',
        'Capybara/FeatureMethods' => 'RSpec/Capybara/FeatureMethods',
        'Capybara/VisibilityMatcher' => 'RSpec/Capybara/VisibilityMatcher',
        'FactoryBot/AttributeDefinedStatically' => 'RSpec/FactoryBot/AttributeDefinedStatically',
        'FactoryBot/CreateList' => 'RSpec/FactoryBot/CreateList',
        'FactoryBot/FactoryClassName' => 'RSpec/FactoryBot/FactoryClassName'
      },
      'rubocop-i18n' => {
        'GetText' => 'I18n/GetText',
        'RailsI18n' => 'I18n/RailsI18n',
        'GetText/DecorateFunctionMessage' => 'I18n/GetText/DecorateFunctionMessage',
        'GetText/DecorateString' => 'I18n/GetText/DecorateString',
        'GetText/DecorateStringFormattingUsingInterpolation' =>
          'I18n/GetText/DecorateStringFormattingUsingInterpolation',
        'GetText/DecorateStringFormattingUsingPercent' =>
          'I18n/GetText/DecorateStringFormattingUsingPercent',
        'RailsI18n/DecorateString' => 'I18n/RailsI18n/DecorateString',
        'RailsI18n/DecorateStringFormattingUsingInterpolation' =>
          'I18n/RailsI18n/DecorateStringFormattingUsingInterpolation'
      }
    }.freeze

    def initialize(hash)
      @hash = hash
    end

    def fix
      DEPRECATED_EXTERNAL_COPS.each_value do |gem_entries|
        gem_entries.each do |old_name, new_name|
          next unless @hash.key?(old_name)

          @hash[new_name] = @hash.delete(old_name)
        end
      end
    end
  end
end
