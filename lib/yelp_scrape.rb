require 'nokogiri'

class Company

  def initialize(file)
    @file = file
  end


  def read_body
    f = File.open(@file)
    html_doc = Nokogiri::HTML(f)
    html_doc.css("body")
  end

  def find_tag(tag)
    read_body.css("#{tag}")
  end

end

class Review

  def initialize(reviews)
    @reviews = reviews
  end




end
