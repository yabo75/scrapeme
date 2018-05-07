class Search < ApplicationRecord
  def initialize(search_terms, telecommute, full_time)
    attr_accessor :search_terms
    attr_accessor :telecommute
    attr_accessor :full_time
  end
end
