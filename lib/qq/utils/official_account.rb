module Qq
  module Utils
    class OfficialAccount

      def initialize(appid:, secret:)
        @session = ::Patron::Session.new(base_url: 'https://api.mp.qq.com', connect_timeout: 10, timeout: 10, force_ipv4: true)
        @appid, @secret = appid, secret
      end

      def access_token=(access_token, expires_in: 7200)
        @access_token = access_token
        @expires_at = (expires_in - 1).seconds.since
      end

      # scope:
      #  - snsapi_userinfo
      #  - snsapi_base
      def get_authorize_uri(redirect_uri, scope: "snsapi_base")
        "https://open.mp.qq.com/connect/oauth2/authorize?appid=#{@appid}&redirect_uri=#{CGI.escape(redirect_uri)}&response_type=code&scope=#{scope}#qq_redirect"
      end

      def get_user_info(open_id, oauth_access_token, lang: "zh_CN")
        JSON.parse(@session.get("/sns/userinfo?access_token=#{oauth_access_token}&openid=#{open_id}&lang=#{lang}").body)
      end

      def get_oauth_access_token(code)
        JSON.parse(@session.get("/sns/oauth2/access_token?appid=#{@appid}&secret=#{@secret}&code=#{code}&grant_type=authorization_code").body)
      end
    end
  end
end
