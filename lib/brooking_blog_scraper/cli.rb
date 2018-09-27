class BrookingBlogScraper::CLI

  def call
    welcome
    goodbye
  end

  def welcome
    puts "Brooking's Top Blog Posts:\n\n"
    puts "Would you like to learn about today's top posts? [Y/n]"
    learn_more
  end

  def learn_more
    input = gets.strip.upcase
    if input == "Y"
      list
    elsif input == "N"
      puts "Okay, maybe later."
    else
      puts "Invalid input - please try again."
      learn_more
    end
  end

  def list
    BrookingBlogScraper::Scraper.blog_scraper
    BrookingBlogScraper::Blog.all.each.with_index(1) do |post, i|
      puts "#{i}. #{post.title.upcase}" + "\n"
      puts "--------------"
    end
    more
  end

  def more
    puts "Would you like to find out more about a story?"
    puts "Enter a number 1-3 to find out more about a particular story."
    input = gets.strip
      if input.to_i.between?(1, 3)
        BrookingBlogScraper::Scraper.expand_post(input)
        puts BrookingBlogScraper::Blog.find(input).title + "\n"
        puts "----"
        puts BrookingBlogScraper::Blog.find(input).story + "\n"
        puts "Would you like to learn about more of today's news? [Y/n]"
        learn_more
      else
        puts "Please try again, invalid input."
        more
      end
  end

  def goodbye
    puts "\nDon't miss the latest blog posts! Visit us again soon."
  end

end
