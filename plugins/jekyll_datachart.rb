require 'rubypants'

module Jekyll
    class RenderDataChartTag < Liquid::Tag
        
        def initialize(tag_name, text, tokens)
            @config = Jekyll.configuration({})['datachart']
            if text.empty?
                if @config['dimensions']
                    @width = @config['dimensions']['width']
                    @height = @config['dimensions']['height']
                else
                    @width = '600'
                    @height = '400'
                end
            else
                @width = text.split(",").first.strip
                @height = text.split(",").last.strip
            end
            super
        end

        def render(context)
            if context['page']['datachart']
				id = context['page']['id']
				#puts id
				o = ""
				i = 0
				files = context['page']['datachart']['files']
				files.each { |file|
				  div = "<div id=\"container_#{i}_#{id}\" class=\"container\" style=\"width: #{@width}px; height: #{@height}px; margin-top: 10px; \" data-files=\"#{file.to_s}\" ></div>"
				  o += div
				  i += 1
				}
				return o
            end
        end
    end
end

Liquid::Template.register_tag('render_datachart', Jekyll::RenderDataChartTag)
