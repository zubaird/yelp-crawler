require 'nokogiri'
require 'rest-client'


class Crawler

  def initialize(initial_page)
    @initial_company = Company.new(initial_page)
    @companies = []
  end

  def companies
    links = @initial_company.also_viewed
    links.each do |link|
      @companies << Company.new(link)
    end
    @companies
  end

  def links
    companies.each do |company|
      p company.also_viewed
    end
  end
end

class Company

  def initialize(page)
    @page = page
    @reviews = []
    @similars = []
  end

  def read_body
    begin
      @nokogiri_argument = File.open(@page)
    rescue SystemCallError
      sleep 1
      @page = RestClient.get @page, :user_agent => 'Chrome'
      @nokogiri_argument = @page.to_str
    end
    html_doc = Nokogiri::HTML(@nokogiri_argument)
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

  def health_score
    find_tag("div.score-block").text.strip
  end

  def also_viewed
    nodes = find_tag(".related-businesses li")
    nodes.each do |node|
      @similars << "www.yelp.com#{node.css("a.biz-name").attr('href').value}"
    end
    @similars.uniq
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
