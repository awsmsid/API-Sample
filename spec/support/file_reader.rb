# frozen_string_literal: true

def read_fixtures(filename)
  File.read(File.join(File.dirname(__FILE__), "../fixtures/#{filename}"))
end
