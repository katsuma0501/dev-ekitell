class SearchController < ApplicationController
  def index
    require 'net/http'
  	@query = params[:query]
  	
  	station_name = params[:query]
  	
  	ekispa_access_key = "LE_jemg3F9C3WEwk"
  	
  	ekispa_url = 'http://api.ekispert.jp/v1/json/'
  	
  	# station_url = ekispa_url + "staton?key=" + ekispa_access_key + "&oldName=上鯖江"
  	
  	# info_url = ekispa_url + "station/info?key=" + ekispa_access_key + "&code=22828&type=rail:nearrail:exit:welfare"
  	
  	
  	station_param = URI.encode_www_form({'key': ekispa_access_key, 'name': station_name})
  	
  	uri = URI.parse( ekispa_url + "staton?#{station_param}")
    # リクエストパラメタを、インスタンス変数に格納
    @query = uri.query
  	
  	# 新しくHTTPセッションを開始し、結果をresponseへ格納
    response = Net::HTTP.start(uri.host, uri.port) do |http|
      # 接続時に待つ最大秒数を設定
      http.open_timeout = 5
      # 読み込み一回でブロックして良い最大秒数を設定
      http.read_timeout = 10
      # ここでWebAPIを叩いている
      # Net::HTTPResponseのインスタンスが返ってくる
      http.get(uri.request_uri)
    end
    # 例外処理の開始
    begin
      # responseの値に応じて処理を分ける
      case response
      # 成功した場合
      when Net::HTTPSuccess
        # responseのbody要素をJSON形式で解釈し、hashに変換
        @message = "success"
        @resBody = response.body
        @result = JSON.parse(response.body)
        # 表示用の変数に結果を格納
        @stationName = @result["Point"][0]["Station"]["Name"]
        @stationCode = @result["Point"][0]["Station"]["code"]
      # 別のURLに飛ばされた場合
      when Net::HTTPRedirection
        @message = "Redirection: code=#{response.code} message=#{response.message}"
      # その他エラー
      else
        @message = "HTTP ERROR: code=#{response.code} message=#{response.message}"
      end
    # エラー時処理
    rescue IOError => e
      @message = "e.message 1"
    rescue TimeoutError => e
      @message = "e.message 2"
    rescue JSON::ParserError => e
      @message = "e.message 3"
    rescue => e
      @message = "e.message 4"
    end
  	
  end

  def method_name
  	"https://api.tokyometroapp.jp/api/v2/datapoints/odpt.StationFacility:TokyoMetro.Shinjuku?acl:consumerKey=51db5b468268e015da781ddd2dca1c9111474e5cf45c5191d2c60271ac537659"
  end
end
