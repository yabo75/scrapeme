class JobsController < ApplicationController








def nokotest

  require 'httparty'
  require 'nokogiri'
  require 'open-uri'

  doc = Nokogiri::HTML(open('https://miami.craigslist.org'))

  puts "### Search for nodes by css"
  doc.css('a', 'span').each do |link|
    puts link.content
  end

  puts "### Search for nodes by xpath"
  doc.xpath('/a', '/span').each do |link|
    puts link.content
  end

  puts "### Or mix and match."
  doc.search('a', '/span').each do |link|
  puts link.content
  end


end






end
