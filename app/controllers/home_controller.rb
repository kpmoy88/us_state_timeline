class HomeController < ApplicationController
  
  def index
    require 'nokogiri'
    require 'open-uri'
   
    @states = File.open("app/assets/data/us_states.xml") { |f| Nokogiri::XML(f) }
  end

end
