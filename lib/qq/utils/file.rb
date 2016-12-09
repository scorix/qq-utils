module Qq
  module Utils
    class File
      def initialize
        @session = ::Patron::Session.new(base_url: 'https://api.mp.qq.com', timeout: 10, force_ipv4: true)
      end

      def upload_voice(access_token, file)
        @session.post('/cgi-bin/media/upload', access_token: access_token, type: "voice", media: file).body
      end

      def upload_image(access_token, file)
        @session.post('/cgi-bin/media/upload', access_token: access_token, type: "image", media: file).body
      end

      def upload_video(access_token, file)
        @session.post('/cgi-bin/media/upload', access_token: access_token, type: "video", media: file).body
      end

      def upload_thumb(access_token, file)
        @session.post('/cgi-bin/media/upload', access_token: access_token, type: "thumb", media: file).body
      end

      def download(access_token, media_id)
        @session.get("/cgi-bin/media/get?access_token=#{access_token}&media_id=#{media_id}").body
      end

    end
  end
end
