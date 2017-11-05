class SearchController < ApplicationController
  def index
  	@query = params[:query]
  end

  def method_name
  	"https://api.tokyometroapp.jp/api/v2/datapoints/odpt.StationFacility:TokyoMetro.Shinjuku?acl:consumerKey=51db5b468268e015da781ddd2dca1c9111474e5cf45c5191d2c60271ac537659"
  end
end
