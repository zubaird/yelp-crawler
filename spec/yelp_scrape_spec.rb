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


describe Crawler do

  before do
    @file = "lib/page.html"
    @crawl = Crawler.new(@file)
  end

  describe "#initial_company_nodes" do
    it "returns the company" do
      expect(@crawl.root_company_nodes.first.class).to eq (Company)
    end
  end

  it "returns the links for each company in also_viewed" do
    expect(@crawl.root_company_nodes_links.class).to eq(Array)
  end

  it "can create new node objects from also_viewed companiea" do
    expect(@crawl.root_company_nodes.class).to eq(Array)
  end

  it "checks the healthscore for each company's links" do
    values = @crawl.root_company_nodes_health_scores

    expect(values.class).to eq(Array)
  end

  it "can keep searching until it finds perfect healthscore" do
    search = @crawl.find_health_score("97")
    expect(search).to eq("97")
  end

end


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

  describe "#health_score" do
    it "gets the healthscore from a Company" do
      webpage = "lib/page.html"
      company = Company.new(webpage)

      expect(company.health_score).to eq("98")
    end
  end

  describe "#name" do
    it "gets the name" do
      webpage = "lib/page.html"
      company = Company.new(webpage)

      expect(company.name).to eq("Fat Angel")
    end
  end

  describe "#also_viewed" do
    it "gets the three viewed companies and puts it in an array" do
      webpage = "lib/page.html"
      company = Company.new(webpage)

      expect(company.also_viewed.length).to eq(3)

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
