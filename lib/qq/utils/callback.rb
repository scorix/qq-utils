require "rexml/document"
require "qpay"

module Qq
  module Utils
    class Callback

      attr_reader :xml, :params

      def initialize(xml)
        @xml = REXML::Document.new(xml).root
        @params = @xml.elements.each_with_object({}) {|x, params| params.store x.name, x.text}
      end

      def validate(qpay_config)
        return false unless @params["trade_state"] == 'SUCCESS'
        check_params = @params.merge("appid" => qpay_config.appid, "mch_id" => qpay_config.mch_id).slice!("sign")
        Qpay.sign(check_params, qpay_config) == @params["sign"]
      end

    end
  end
end
