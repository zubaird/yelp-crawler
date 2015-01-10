require_relative "../lib/yelp_scrape.rb"


file = "http://www.yelp.com/biz/fat-angel-san-francisco"

new_company = Company.new(file)

p review = new_company.reviews.first
