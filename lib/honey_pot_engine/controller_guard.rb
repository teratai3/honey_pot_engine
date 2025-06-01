module HoneyPotEngine
  module ControllerGuard
    extend ActiveSupport::Concern

    def self.prepended(base)
      # prepend の時点でクラスに特異メソッドを定義
      base.class_eval do
        @skip_honeypot_check = false

        def self.skip_honeypot!
          @skip_honeypot_check = true
        end

        def self.honeypot_skipped?
          @skip_honeypot_check == true
        end
      end

      base.before_action :check_honeypot
    end
    
    private

    # ハニーポットフィールドに値が入っていたら bot と判断してブロック
    def check_honeypot
      return if self.class.honeypot_skipped?
      if params[:honeypot].present?
        Rails.logger.warn "[HONEYPOT] Blocked spam submission: #{request.remote_ip}"
        # head :forbidden
        render template: "errors/forbidden", status: :forbidden
      end
    end
  end
end
