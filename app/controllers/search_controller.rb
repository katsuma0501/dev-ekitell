class SearchController < ApplicationController
  def indextwo
    require 'net/http'
    require 'uri'
    require 'json'

  	@query = params[:query]
  	
  	# station_name = params[:query]
  	
  	ekispa_access_key = "LE_jemg3F9C3WEwk"
  	
  	ekispa_url = 'http://api.ekispert.jp/v1/json/'
  	
  	station_param = URI.encode_www_form({'key': ekispa_access_key, 'name': @query})
  	
  	uri = URI.parse( ekispa_url + "station?#{station_param}")
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
        if @result["ResultSet"]["Point"].kind_of?(Array)
          @stationName = @result["ResultSet"]["Point"][0]["Station"]["Name"]
          @stationCode = @result["ResultSet"]["Point"][0]["Station"]["code"]
        else
          @stationName = @result["ResultSet"]["Point"]["Station"]["Name"]
          @stationCode = @result["ResultSet"]["Point"]["Station"]["code"]
        end
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
    
    
    #
    #
    #
    station_param = URI.encode_www_form({'key': ekispa_access_key, 'code': @stationCode, 'type': 'welfare'})
    uri = URI.parse( ekispa_url + "station/info?#{station_param}")
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
        @facility = @result["ResultSet"]["Information"]["WelfareFacilities"]
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
  
  def index
    require 'net/http'
    require 'uri'
    require 'json'
    $url = "https://api.tokyometroapp.jp/api/v2/datapoints/odpt.StationFacility:TokyoMetro.Shinjuku?acl:consumerKey=51db5b468268e015da781ddd2dca1c9111474e5cf45c5191d2c60271ac537659"
    
    # 例.新宿三丁目 副都心線 〜 明治神宮　副都心 - 千代田線　〜　赤坂
    #   新宿三丁目  出口4エレベータ　-> 改札外エレベータ -> 改札内エレベータ -> 副都心線ホーム
    #   めいじじんぐう　副都心ホーム　改札内エレベータ -> 千代田線内ホーム行きエレベータ
    # 　赤坂　改札内エレベータ　-> 出口３aエレベータ(地上)
    
    # 新宿三丁目
    "https://api.tokyometroapp.jp/api/v2/datapoints/odpt.StationFacility:TokyoMetro.ShinjukuSanchome?acl:consumerKey=51db5b468268e015da781ddd2dca1c9111474e5cf45c5191d2c60271ac537659"
    # 明治神宮
    "https://api.tokyometroapp.jp/api/v2/datapoints/odpt.StationFacility:TokyoMetro.MeijiJingumae?acl:consumerKey=51db5b468268e015da781ddd2dca1c9111474e5cf45c5191d2c60271ac537659"
  end

  def method_name
  	"https://api.tokyometroapp.jp/api/v2/datapoints/odpt.StationFacility:TokyoMetro.Shinjuku?acl:consumerKey=51db5b468268e015da781ddd2dca1c9111474e5cf45c5191d2c60271ac537659"
  end
end
