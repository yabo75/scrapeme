class Job < ApplicationRecord
  def initialize(title,link, post_time, city)
    attr_accessor :title
    attr_accessor :link
    attr_accessor :post_time
    attr_accessor :city
  end



def categories
categories = {"admin/office" => "ofc", "business" => "bus", "customer service" => "csr", "education" => "edu", "engineering" => "egr", "etcetera" => "etc", "finance" => "acc", "food/bev/hosp" => "fbh", "general labor" => "lab", "government" => "gov", "healthcare" => "hea", "human resource" => "hum", "legal" => "lgl", "manufacturing" => "mnu", "marketing" => "mar", "media" => "med", "nonprofit" => "npo", "real estate" => "rej", "retail/wholesale" => "ret", "sales" => "sls", "salon/spa/fitness" => "spa", "science" => "sci", "security" => "sec", "skilled trades" => "trd", "selected  software" => "sof", "systems/networking" => "sad", "tech support" => "tch", "transport" => "trp", "tv video radio" => "tfr", "web design" => "web", "writing" => "wri"}
@categories = categories
end

# Rails.cache.fetch("stream_data", expires_in: 5.minutes) do
#   Job.search
# end

def self.search

    #require 'open_uri_redirections'
    require 'nokogiri'
    require 'open-uri'

    get '/' do
    # telecommute = false
    # full_time = false

    if telecommute == true
    telecommuter = '&is_telecommuting=1'
    else
    telecommuter = ''
    end

    if full_time == true
    wageslave = '&employment_type=1'
    else
    wageslave = ''
    end




    terms = ['full stack', 'full-stack']

    # ?query=#{term}#{telecommuter}#{wageslave}
    # ?query=#{term}

    @county.each_value do |county|
      terms.each do |term|
        url = "https://miami.craigslist.org/search/#{county}sof?query=#{term}#{telecommuter}#{wageslave}"
          #
          # puts '====================================='
          # puts '====================================='
          # puts '                                     '
          # puts "    #{county} // #{term}             "
          # puts '                                     '
          # puts '====================================='
          # puts '====================================='


        document = open(url)
        content = document.read
        site_content = Nokogiri::HTML(content)



      site_content.css('.content').css('.result-row').each do |row|
      job.title = row.css('.hdrlnk').first.inner_text
      job.link = row.css('.hdrlnk').first.attributes["href"].value
      job.post_time = row.css('time').first.attributes["datetime"].value
      location = row.css('.result-hood')

      if location.any?
        job.city = location.first.inner_text.strip
      else
        job.city = ''
      end




      # puts "     #{location}, #{job_title}       "
      # puts "     Posted: #{post_time}            "
      # puts "     Link:  #{url}                   "
      # puts '====================================='


    end

    end
    end

      @search = Jobs.search do
      end
  end


end
end

# ============
# https://miami.craigslist.org/search/sof?query=rails
# https://miami.craigslist.org/d/jobs/search/jjj
# https://miami.craigslist.org/search/sof?query=#{search}
# array.slice[-3, 3]
# ============
