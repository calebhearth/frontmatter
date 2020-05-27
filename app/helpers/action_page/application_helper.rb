module ActionPage
  module ApplicationHelper
    def page_content(page)
      controller.render_to_string("#{page.class.view_key}/#{page.slug}", layout: false).split('---').last
    end
  end
end
