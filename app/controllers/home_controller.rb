class HomeController < ApplicationController
  
  def index
    require 'nokogiri'
    require 'open-uri'
   
    @page = File.open("app/assets/data/us_states.xml") { |f| Nokogiri::XML(f) }
  end

end
