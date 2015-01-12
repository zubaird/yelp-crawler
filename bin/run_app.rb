require_relative "../lib/yelp_scrape.rb"


file = "lib/page.html"
crawl = Crawler.new(file)
crawl.find_health_score("100")
