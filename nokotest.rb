



==================
==================

class CreateJobs < ActiveRecord::Migration[5.1]
  def self.up
  create_table :jobs do |t|
    t.string :title
    t.text :link
    t.string :city
    t.datetime :post_time

    t.timestamps
  end

  add_index :jobs, :post_time
  add_index :jobs, :city
  add_index :jobs, :title
  add_index :jobs, :link, :unique => true
  end

  def self.down
  drop_table :jobs
  end
end


==================
==================

class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :search_terms
      t.boolean :telecommute
      t.boolean :full_time

      t.timestamps
    end

    add_index :searches, :search_terms
    add_index :searches, :telecommute
    add_index :searches, :full_time
  end

    def self.down
    drop_table :searches
    end

end

==================
==================

<!DOCTYPE html>
<html>
  <head>
    <title>Scrapeme</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
  </head>

  <body>
    <%= yield %>
  </body>

  <script type="text/javascript">
      M.AutoInit();
  </script>
</html>

==================
==================

<% form_tag(search_path, :method => "get") do %>
  <%= label_tag(:query, "Search for:") %>
  <%= text_field_tag(:query) %>
  <%= submit_tag("Search") %>
<% end %>



<!-- <% @job_titles.each_with_index do |job, number, link| %>
<p>
<%= number %>: <%= job %><br><%= link %>
<br>
</p>
<% end %> -->

==================
==================

Rails.application.routes.draw do
  resources :searches
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'jobs#scrapeme'
  get '/scrapeme' => 'jobs#scrapeme'
end

==================
==================

require 'query_params'

Rails.cache.fetch("stream_data", expires_in: 5.minutes) do
  Job.search
end

def counties
counties = {"selected  all south florida" => "", "all south florida" => "", "broward county" => "brw", "miami/dade" => "mdc", "palm beach co" => "pbc"}
@counties = counties
end

def categories
categories = {"admin/office" => "ofc", "business" => "bus", "customer service" => "csr", "education" => "edu", "engineering" => "egr", "etcetera" => "etc", "finance" => "acc", "food/bev/hosp" => "fbh", "general labor" => "lab", "government" => "gov", "healthcare" => "hea", "human resource" => "hum", "legal" => "lgl", "manufacturing" => "mnu", "marketing" => "mar", "media" => "med", "nonprofit" => "npo", "real estate" => "rej", "retail/wholesale" => "ret", "sales" => "sls", "salon/spa/fitness" => "spa", "science" => "sci", "security" => "sec", "skilled trades" => "trd", "selected  software" => "sof", "systems/networking" => "sad", "tech support" => "tch", "transport" => "trp", "tv video radio" => "tfr", "web design" => "web", "writing" => "wri"}
@categories = categories
end


class Job < ApplicationRecord

def search

    #require 'open_uri_redirections'
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





      render template: 'jobs/home'
  end


end
end

# ============
# https://miami.craigslist.org/search/sof?query=rails
# https://miami.craigslist.org/d/jobs/search/jjj
# https://miami.craigslist.org/search/sof?query=#{search}
# array.slice[-3, 3]
# ============














=================
=================

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
