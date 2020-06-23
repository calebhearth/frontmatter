module Frontmatter
  class Page
    extend ActiveModel::Naming
    attr_reader :slug

    def self.all
      Dir[pages_directory]
        .reject { %w(index show).include? File.basename(_1.split('.')[0]) }
        .map { |f| new(f) }
    end

    def self.find(slug)
      all.find { _1.slug == slug }
    end

    def self.pages_directory
      Rails.root.join("app", "views", view_key, '*.yaml').freeze
    end

    def initialize(filename)
      @slug = File.basename(filename.split('.')[0])
      @frontmatter = YAML.load(File.read(filename)).with_indifferent_access
    end

    # TODO: Define attribute methods to speed this up
    def method_missing(m, *args, &block)
      if value = @frontmatter[m]
        return value
      end
      super
    end

    def respond_to_missing(m)
      @frontmatter.key(m)
    end

    def to_param
      slug
    end

    def self.view_key
      model_name.route_key
    end
  end
end
