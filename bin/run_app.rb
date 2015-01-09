require_relative "../lib/yelp_scrape.rb"


yelp_page = Company.new("lib/page.html")

node2 = "#wrap > div.biz-country-us > #super-container > div > div > div.column.column-alpha.main-section > div:nth-child(3) > div.feed > div.review-list"

review_nodes = "#super-container > div > div > div.column.column-alpha.main-section > div:nth-child(3) > div.feed > div.review-list > ul"

reviews = yelp_page.find_tag(review_nodes)

yelp_page.reviews_from(review_nodes)
