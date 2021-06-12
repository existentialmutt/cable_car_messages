# frozen_string_literal: true

require "rails/generators/rails/resource/resource_generator"

module CableReady
  module Generators
    class ScaffoldGenerator < ResourceGenerator # :nodoc:
      include Rails::Generators::ResourceHelpers

      remove_hook_for :resource_controller
      remove_class_option :actions

      class_option :stylesheets, type: :boolean, desc: "Generate Stylesheets"
      class_option :stylesheet_engine, desc: "Engine for Stylesheets"
      class_option :assets, type: :boolean
      class_option :resource_route, type: :boolean
      class_option :scaffold_stylesheet, type: :boolean

      def handle_skip
        @options = @options.merge(stylesheets: false) unless options[:assets]
        @options = @options.merge(stylesheet_engine: false) unless options[:stylesheets] && options[:scaffold_stylesheet]
      end

      hook_for :scaffold_controller, required: true

      hook_for :assets do |assets|
        invoke assets, [controller_name]
      end

      hook_for :stylesheet_engine do |stylesheet_engine|
        if behavior == :invoke
          invoke stylesheet_engine, [controller_name]
        end
      end

      def create_root_folder
        empty_directory File.join("app/views", controller_file_path)
      end

      #TODO rename _resource.html.erb
      def copy_view_files
        available_views.each do |view|
          formats.each do |format|
            target_view = if view == "_resource"
                "_#{controller_file_path.singularize}"
              else
                view
              end

            filename = filename_with_extensions(target_view, format)
            template filename, File.join("app/views", controller_file_path, filename)
          end
        end
      end

      private
      def available_views
        %w(index edit show new _form _resource)
      end
    end
  end
end
