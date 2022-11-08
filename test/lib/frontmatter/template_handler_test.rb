require "test_helper"

module Frontmatter
  class TemplateHandlerTest < ActiveSupport::TestCase
    def test_call
      source = "On the twenty-fourth day of the month GORPIAIOS"
      identifier = "stones/rosetta.html.erb.yaml"
      handler = :yaml
      template = ActionView::Template.new(source, identifier, handler, locals: {}, format: :html)

      result = TemplateHandler.call(template, source)

      assert_equal("\n@output_buffer.to_s".b, result)
    end
  end
end
