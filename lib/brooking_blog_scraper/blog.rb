require 'pry'
class BrookingBlogScraper::Blog
  attr_accessor :title, :url, :story

  @@all = []

  def self.all
    @@all ||= blog_scraper
  end

  def save
    @@all << self
  end

  def self.find(input)
    self.all[input.to_i - 1]
  end
end
