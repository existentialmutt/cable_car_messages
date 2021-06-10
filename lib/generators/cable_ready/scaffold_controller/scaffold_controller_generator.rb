# frozen_string_literal: true

require "rails/generators/resource_helpers"

module CableReady
  module Generators
    class ScaffoldControllerGenerator < NamedBase # :nodoc:
      include ResourceHelpers

      check_class_collision suffix: "Controller"

      class_option :helper, type: :boolean
      class_option :orm, banner: "NAME", type: :string, required: true,
                         desc: "ORM to generate the controller for"

      class_option :skip_routes, type: :boolean, desc: "Don't add routes to config/routes.rb."

      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      def create_controller_files
        template "controller.rb", File.join("app/controllers", controller_class_path, "#{controller_file_name}_controller.rb")
      end

      hook_for :template_engine, as: :scaffold do |template_engine|
        invoke template_engine
      end

      hook_for :resource_route, required: true do |route|
        invoke route unless options.skip_routes?
      end

      hook_for :test_framework, as: :scaffold

      # Invoke the helper using the controller name (pluralized)
      hook_for :helper, as: :scaffold do |invoked|
        invoke invoked, [ controller_name ]
      end

      private
        def permitted_params
          attachments, others = attributes_names.partition { |name| attachments?(name) }
          params = others.map { |name| ":#{name}" }
          params += attachments.map { |name| "#{name}: []" }
          params.join(", ")
        end

        def attachments?(name)
          attribute = attributes.find { |attr| attr.name == name }
          attribute&.attachments?
        end
    end
  end
end
