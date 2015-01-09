require 'nokogiri'
require 'rest-client'

class Company

  def initialize(page)
    @page = page
    @reviews = []
  end


  def read_body
    begin
      @thing = File.open(@page)
    rescue SystemCallError
      sleep 1
      @page = RestClient.get @page, :user_agent => 'Chrome'
      @thing = @page.to_str
    end
    html_doc = Nokogiri::HTML(@thing)
    html_doc.css("body")
  end

  def find_tag(tag)
    read_body.css("#{tag}")
  end

  def reviews
    nodes = find_tag("div.review--with-sidebar")
    nodes.each do |node|
      @reviews << Review.new(node)
    end
    @reviews
  end
end

class Review

  def initialize(node)
    @review_info = node
  end

  def date
    @review_info.css("meta[itemprop=datePublished]").attr('content').value
  end

  def rating
    @review_info.css("meta[itemprop=ratingValue]").attr('content').value
  end

  def user_name
    @review_info.css("meta[itemprop=author]").attr('content').value
  end

  def contents
    @review_info.css("p[itemprop=description]").inner_text
  end

end
