# We will be working with the following Yelp page: http://www.yelp.com/biz/fat-angel-san-francisco. Our goal will be to count the number of 5 star reviews Fat Angel has gotten.
#
# To start we will not concern ourselves with downloading the web page and HTTP requests (that is this afternoon). You can find the HTML for this page in data/fat-angel.html.
#
# First things first, we need to get this HTML file into a Nokogiri object to parse.
# Using Ruby's file I/O capabilities, read in the file as a single string of HTML.
#
# Make a Nokogiri HTML document with this string of HTML.
#
# Now that we have our HTML file as a Nokogiri HTML object,
# we can begin to have some fun! This will be easiest to do interactively in an irb or Pry shell.
#
#   Using CSS selectors in Nokogiri write a function to
# extract the first review (everything contained within the <li>).
# HINT: Use the Chrome Web inspector to find out how to navigate and extract the review
#
#   Now that we have extracted one review, we can structure the information contained within. Create a Review class to store the:
#
#   Date of review
#   Number of Stars
#   User name of user who left review
#   Text content of Review
#   The original raw string of HTML corresponding to the review


require_relative '../lib/yelp_scrape.rb'

describe Company do
  describe "#read_body" do
    it "reads an html page body" do
      file = "spec/test_data.html"
      new_scrape = Company.new(file)

      reading = new_scrape.read_body.text.strip

      expect(reading).to eq("test data")
    end
  end

  describe "#find_tag" do
    it "it can find a nested tag" do
      file = "spec/test_data.html"
      new_scrape = Company.new(file)

      file = "spec/test_data.html"

      reading = new_scrape.find_tag("p").text.strip

      expect(reading).to eq("test data")
    end
  end

  xdescribe "#reviews" do
    it "shows all the reviews" do

    end
  end

end

#   Date of review
#   Number of Stars
#   User name of user who left review
#   Text content of Review
#   The original raw string of HTML corresponding to the review
describe Review do

  before do
    @file = "spec/test_data.html"
    @new_scrape = Company.new(file)
  end

  describe "#date" do
    it "shows the date" do
      review = Review.new(review)

      date = "12/27/2014"

      expect(first_review.date).to eq(date)
    end
  end

  describe "#rating" do

  end

  describe "#user_name" do

  end

  describe "#content" do


  end

  describe "#html" do

  end


end
