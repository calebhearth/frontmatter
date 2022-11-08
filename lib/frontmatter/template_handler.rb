module Frontmatter
  class TemplateHandler
    def self.call(template, source)
      new(template, source).call
    end

    def initialize(template, source)
      @template = template
      @source = source
    end

    def call
      handler_for_template.call(@template, source_without_yaml)
    end

    private

    def handler_for_template
      handler = ActionView::Resolver::PathParser.new
        .parse(path_without_yaml)
        .details
        .handler
      ActionView::Template.handler_for_extension(handler)
    end

    def source_without_yaml
      @source.lines[last_line+1...].join
    end

    def path_without_yaml
      @template.short_identifier.sub(/.ya?ml\z/, '')
    end

    def last_line
      YAML.parse(@source).root.end_line
    end
  end
end
