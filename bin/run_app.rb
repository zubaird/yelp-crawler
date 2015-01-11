require_relative "../lib/yelp_scrape.rb"


file = "lib/page.html"
crawl = Crawler.new(file)

p crawl.root_company_nodes
