# coding: utf-8

module Ruboty
  module Handlers
    class Sorena < Base
      on /^(それな|sorena)$/i, name: "sorena", description: "Request それな", all: true

      def sorena(message)
        unless room(message.from) =~ ignored_channel
          body = %w(
            https://pbs.twimg.com/media/B1_ybnKCMAAApSa.jpg
            https://pbs.twimg.com/media/B1_823pCIAAvwwQ.jpg).sample
          message.reply(body)
        end
      end

      private

      def ignored_channel
        Regexp.new ENV['SORENA_IGNORED_CHANNEL']
      end

      def room(from)
        channels.find { |channel| channel['id'] == from }['name']
      end

      def channels
        @channels ||= JSON.parse(open(api_channels_list).read)['channels']
      end

      def api_channels_list
        "https://slack.com/api/channels.list?token=#{ENV['RUBOTY_SORENA_SLACK_TOKEN']}"
      end
    end
  end
end
