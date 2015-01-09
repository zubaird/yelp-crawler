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
    it "reads an html page" do
      file = "spec/test_data.html"
      company = Company.new(file)

      reading = company.read_body.text.strip

      expect(reading).to eq("test data")
    end

    it "reads an html page body when not a local file" do
      webpage = "www.google.com"
      company = Company.new(webpage)

      reading = company.read_body.text.strip

      expect(reading).to include("google")
    end
  end

  describe "#find_tag" do
    it "it can find a nested tag" do
      file = "spec/test_data.html"
      company = Company.new(file)

      file = "spec/test_data.html"

      reading = company.find_tag("p").text.strip

      expect(reading).to eq("test data")
    end
  end

  describe "#get_reviews" do
    it "gets all the reviews from a Company" do
      webpage = "lib/page.html"
      company = Company.new(webpage)

      reviews = company.reviews

      expect(reviews.first.class).to eq(Review)
      expect(reviews.first.date).to eq("2014-12-27")
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
    @file = "lib/page.html"
    @new_company = Company.new(@file)
    @review = @new_company.reviews.first
  end

  describe "#date" do
    it "shows the date" do
      date = "2014-12-27"

      expect(@review.date).to eq(date)
    end
  end

  describe "#rating" do
    it "shows the rating" do
      rate = "5.0"

      expect(@review.rating).to eq(rate)
    end
  end

  describe "#user_name" do
    it "shows the user name" do
      username = "Stephanie F."

      expect(@review.user_name).to eq(username)
    end
  end

  describe "#content" do
    it "shows the contents" do
      content = "Beer/wine selection: outstanding"

      expect(@review.contents).to include(content)
    end

  end

  describe "#html" do

  end


end
