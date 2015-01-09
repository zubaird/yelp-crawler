require_relative "../lib/yelp_scrape.rb"


yelp_page = YelpScraper.new("lib/page.html")
review_nodes = "#super-container > div > div > div.column.column-alpha.main-section > div:nth-child(3) > div.feed > div.review-list > ul"

reviews = yelp_page.find_tag(review_nodes).class

Review.new(reviews)
