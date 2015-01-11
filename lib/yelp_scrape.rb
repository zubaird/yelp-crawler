require 'nokogiri'
require 'rest-client'


class Crawler

  def initialize(root_page)
    @root_company = Company.new(root_page)
    @root_companies = []
  end

  def root_company_nodes
    links = @root_company.also_viewed
    links.each do |link|
      @root_companies << Company.new(link)
    end
    @root_companies
  end

  def current_company_nodes(company)
    company_nodes = []
    links = company.also_viewed
    links.each do |link|
      company_nodes << Company.new(link)
    end
    company_nodes
  end

  def root_company_nodes_links
    root_company_nodes.each do |company|
      company.also_viewed
    end
  end

  def root_company_nodes_health_scores
    @health_scores = []
    root_company_nodes.each do |company|
      @health_scores << company.health_score
    end
    @health_scores
  end

  def find_health_score(score)
    @queue = [@root_company]

    while !@queue.empty?
      current_company = @queue.shift
      puts "Current company is #{current_company.name}
          with #{current_company.health_score} "
      if current_company.health_score == score
        return current_company
      else
        @queue.concat current_company_nodes(current_company)
      end
    end
    return nil
  end
end

class Company

  def initialize(page)
    @url = page
    @reviews = []
    @similars = []
  end

  def read_body
    begin
      @nokogiri_argument = File.open(@url)
    rescue SystemCallError
      sleep 1
      @page = RestClient.get @url, :user_agent => 'Chrome'
      @nokogiri_argument = @page.to_str
    end
    html_doc = Nokogiri::HTML(@nokogiri_argument)
    html_doc.css("body")
  end

  def find_tag(tag)
    read_body.css("#{tag}")
  end

  def name
    find_tag("h1.biz-page-title").text.strip
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
