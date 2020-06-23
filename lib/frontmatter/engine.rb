module Frontmatter
  class Engine < ::Rails::Engine
    isolate_namespace Frontmatter
    initializer "frontmatter.load" do
      ActiveSupport.on_load :action_view do
        ActionView::Template.register_template_handler(
          # Accept all existing handlers with additional .yaml or .yml extension
          *ActionView::Template.template_handler_extensions.flat_map { %W(#{_1}.yaml #{_1}.yml) },
          :yml, :yaml,
          Frontmatter::TemplateHandler
        )
      end
    end
  end
end
