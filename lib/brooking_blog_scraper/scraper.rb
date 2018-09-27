require 'pry'
class BrookingBlogScraper::Scraper

  def self.blog_scraper
    doc = Nokogiri::HTML(open('https://www.brookings.edu/'))

    #blog_list = doc.css('.post-count-3').first.children.search('.article-info')
    blog_list = doc.css('.article-info')
    blog_list.each do |info|

      blog = BrookingBlogScraper::Blog.new
      blog.title = info.css('h4.title').text
      blog.url = "https://www.brookings.edu/#{info.css('.title a').attr('href').value}"
      blog.save
    end
  end

  def self.expand_post(input)
    blog = BrookingBlogScraper::Blog.all[input.to_i - 1]
    doc = Nokogiri::HTML(open(blog.url))
    blog.story = doc.css('p').text
    blog
  end
end
