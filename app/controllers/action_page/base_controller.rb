module ActionPage
  class BaseController < ::ApplicationController
    cattr_reader :page_class
    helper ActionPage::ApplicationHelper

    def self.renders_page(page)
      @@page_class = page
    end

    def self.page_class
      @@page_class ||= begin
       page_class = name.sub(/Controller\z/, '')
       page_class.singularize.constantize
       rescue NameError
         raise #ActionPage::MissingPageClass.new(page: page_class)
       end
    end

    def initialize(*args)
      super
      append_view_path("app/views/#{self.class.page_class.view_key}")
    end

    def index
      @pages = page_class.all
    end

    def show
      @page = page_class.find(params[:id])
      if @page.nil?
        raise ActionController::RoutingError.new("Not Found")
      end
      render
    end
  end
end
