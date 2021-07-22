# frozen_string_literal: true

require 'json-schema'
require 'active_support/hash_with_indifferent_access'

DATE_REGEX = /^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$/

RSpec::Matchers.define :be_valid_jsonapi do
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/support/api/schemas"
    schema_path = "#{schema_directory}/json-api.json"
    JSON::Validator.validate!(schema_path, response.body)
  end
end

RSpec::Matchers.define :have_jsonapi_resource_id do |expected|
  match do |actual|
    actual = json_body unless actual.respond_to?(:with_indifferent_access)
    actual.with_indifferent_access[:data][:id] == expected
  end
end

RSpec::Matchers.define :have_jsonapi_resource_id? do
  match do |actual|
    actual.with_indifferent_access[:data].key? :id
  end
end

RSpec::Matchers.define :have_jsonapi_attributes do |expected|
  match do |actual|
    actual = json_body unless actual.respond_to?(:with_indifferent_access)
    attributes = actual.with_indifferent_access[:data][:attributes]
    expected.each_pair.all? do |attr, val|
      attributes[attr] == val
    end
  end
end

RSpec::Matchers.define :have_jsonapi_meta_data do |expected|
  match do |actual|
    actual = json_body unless actual.respond_to?(:with_indifferent_access)
    meta = actual.with_indifferent_access[:data][:meta]
    expected.each_pair.all? do |attr, val|
      meta[attr] == val
    end
  end
end

RSpec::Matchers.define :have_jsonapi_collection do |expected|
  match do |actual|
    actual = json_body unless actual.respond_to?(:with_indifferent_access)

    actual.with_indifferent_access[:data].each_with_index do |item, index|
      attributes = item[:attributes]
      all_matched = expected[index].each_pair.all? do |attr, val|
        attr.to_sym == :id ? item[attr] == val : attributes[attr] == val
      end
      return false unless all_matched # exit the loop early
    end
  end
end

RSpec::Matchers.define :have_jsonapi_type do |expected|
  match do |actual|
    actual.with_indifferent_access[:data][:type].to_s == expected.to_s
  end
end

RSpec::Matchers.define :have_jsonapi_self_link do |expected|
  match do |actual|
    actual.with_indifferent_access[:data][:links][:self] == expected
  end
end

RSpec::Matchers.define :have_jsonapi_self_link? do
  match do |actual|
    actual.with_indifferent_access[:data].key? :links
  end
end

RSpec::Matchers.define :have_jsonapi_relationships do |*expected|
  match do |actual|
    expected.all? do |relationship|
      actual.with_indifferent_access[:data][:relationships][relationship].present?
    end
  end
end

# expect relationship: url e.g. service: 'http://localhost:3000/services/msn'
RSpec::Matchers.define :have_jsonapi_relationships_related_link do |expected|
  match do |actual|
    relationships = actual.with_indifferent_access[:data][:relationships]
    expected.each_pair.all? do |relationship, expected_link|
      relationships[relationship][:links][:related] == expected_link
    end
  end
end

RSpec::Matchers.define :have_jsonapi_relationships_data do |expected|
  match do |actual|
    actual = json_body unless actual.respond_to?(:with_indifferent_access)

    relationships = actual.with_indifferent_access[:data][:relationships]
    expected.each_pair.all? do |relationship, expected_data|
      if expected_data.respond_to?(:each_pair)
        expected_data.each_pair.all? do |attr, expected_val|
          relationships[relationship][:data][attr] == expected_val
        end
      else
        relationships[relationship][:data] == expected_data
      end
    end
  end
end

RSpec::Matchers.define :have_jsonapi_error do |expected|
  match do |actual|
    actual = json_body unless actual.respond_to?(:each_pair)
    expected.each_pair.all? do |key, val|
      actual.deep_symbolize_keys[:errors].any? { |err| err[key] == val }
    end
  end
end

def expect_json_date(*args)
  if args.length == 2
    path = args[0]
    attribute = args[1].to_sym
    expect_json_types(path, attribute => :date)
    expect_json(path, attribute => regex(DATE_REGEX))
  else
    attribute = args[0].to_sym
    expect_json_types(attribute => :date)
    expect_json(attribute => regex(DATE_REGEX))
  end
end
