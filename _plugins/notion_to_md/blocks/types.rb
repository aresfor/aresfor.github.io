require 'open-uri'

module NotionToMd
  module Blocks
    class Types
      class << self
        def image(block)
          type = block[:type].to_sym
          url = URI.parse(block.dig(type, :url))
          
          # we can also retrieve a caption here like this:
          # caption = convert_caption(block)

          # https://example.com/filename.jpg?queryParams -> filename.jpg
          filename = "assets/post-images/#{url.to_s.split('/')[-1].split('?')[0]}"
          IO.copy_stream(url.open, filename)

          Jekyll.logger.info("Image #{File.absolute_path(filename)} #{"OK".green}")

          return "![](#{filename})" 
          # or you can use jekyll_picture_tag plugin and return liquid 
          # tag "picture" here, which automatically generates responsive 
          # images for you.
        end
      end
    end
  end
end
