#require 'open_uri_redirections'
require 'sinatra'
# require 'httparty'
require 'nokogiri'
require 'open-uri'

get '/' do
telecommute = false
full_time = false

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



counties = ['brw/', 'mdc/', 'pbc/']
 terms = ['full stack', 'full-stack']

# ?query=#{term}#{telecommuter}#{wageslave}
# ?query=#{term}

counties.each do |county|
  terms.each do |term|
    url = "https://miami.craigslist.org/search/#{county}sof?query=#{term}#{telecommuter}#{wageslave}"

      puts '====================================='
      puts '====================================='
      puts '                                     '
      puts "    #{county} // #{term}             "
      puts '                                     '
      puts '====================================='
      puts '====================================='


    document = open(url)
    content = document.read
    site_content = Nokogiri::HTML(content)



  site_content.css('.content').css('.result-row').each do |row|
  job_title = row.css('.hdrlnk').first.inner_text
  url = row.css('.hdrlnk').first.attributes["href"].value
  post_time = row.css('time').first.attributes["datetime"].value
  city = row.css('.result-hood')

  if city.any?
    location = city.first.inner_text.strip
  else
    location = ''
  end



  
  puts "     #{location}, #{job_title}       "
  puts "     Posted: #{post_time}            "
  puts "     Link:  #{url}                   "
  puts '====================================='


end

end
end

# render template: 'jobs/home'
end


# attributes[:title] = doc.css("a.hdrlnk")
# attributes[:link] = link.attribute('href')
# attributes[:city] = link.text
# attributes[:post_time] =

#require 'open_uri_redirections'
# require 'open-uri'
# require 'nokogiri'
#
# cities       = ['sanfrancisco', 'seattle']
# search_terms = ['ruby', 'python', 'react', 'java']
#
# cities.each do |city|
#   search_terms.each do |search_term|
#     url = "https://#{city}.craigslist.org/search/cpg?query=#{search_term}&is_paid=all"
#
#     document = open(url)
#     content = document.read
#     parsed_content = Nokogiri::HTML(content)
#
#     puts '========================================================='
#     puts '-                                                       -'
#     puts "-   #{city} - #{search_term}                                 -"
#     puts '-                                                       -'
#     puts '========================================================='
#
#
#
#     parsed_content.css('.content').css('.result-row').each do |row|
#       title        = row.css('.hdrlnk').first.inner_text
#       link         = row.css('.hdrlnk').first.attributes["href"].value
#       posted_at    = row.css('time').first.attributes["datetime"].value
#       hood_elem    = row.css('.result-hood')
#
#
#       if hood_elem.any?
#         neighborhood = hood_elem.first.inner_text.strip
#       else
#         neighborhood = ''
#       end
#
#       puts "#{title} #{neighborhood}"
#       puts "link: #{link}"
#       puts "Posted at #{posted_at}"
#       puts '======================================================='
#   end
#  end
# end
