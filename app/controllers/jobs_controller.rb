class JobsController < ApplicationController

def scrapeme

  require 'httparty'
  require 'nokogiri'


    search = params['job']
    url = "https://miami.craigslist.org/search/#{search}"
    response = HTTParty.get url

    dom = Nokogiri::HTML(response.body)

    links = dom.css("a.hdrlnk", "a.href", "a.value")
    classifications = dom.css("a.data-cat")
    @job_titles = links.map(&:to_str)
    @classifications = classifications.map(&:to_str)


    render template: 'jobs/home'
end
end



# class ParallelController < ApplicationController
#
#   def parallelrate
#     require 'openssl'
#     doc = Nokogiri::HTML(open('https://www.abokifx.com/', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
#
#     entries = doc.css('.lagos-market-rates-inner')
#     rate = entries.css('table')[0].css('tr')[1].css('td')[1].text
#     @formattedrate = rate[6..8]
#     render template: 'parallel/home'
#   end
#
# end
