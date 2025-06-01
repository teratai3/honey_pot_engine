module HoneyPotEngine
  module FormInjector
    # Railsのform_withをオーバーライドし、最初に隠しフィールドを挿入
    def form_with(**options, &block)
      super(**options) do |form|
        concat hidden_honeypot_field
        block.call(form)
      end
    end

    # Railsのform_forにも同様の拡張を適用（レガシー対応用）
    def form_for(record, options = {}, &block)
      super(record, options) do |form|
        concat hidden_honeypot_field
        block.call(form)
      end
    end

    # form_tag（非モデルベース）に対してもハニーポットを自動挿入
    def form_tag(url_for_options = {}, options = {}, &block)
      super(url_for_options, options) do
        concat hidden_honeypot_field
        block.call
      end
    end

    private
    def hidden_honeypot_field
      # このコントローラが honeypot チェックをスキップする設定になっている場合は、入力フィールドも出力しない
      # controller.class は現在のビューをレンダリングしているコントローラクラス
      # respond_to? によってメソッド存在確認を行い、安全に動作させる
      return "".html_safe if controller.class.respond_to?(:honeypot_skipped?) && controller.class.honeypot_skipped?

      # ボットによる自動入力を検知するためのハニーポットフィールドを出力
      tag.input type: "text", name: "honeypot", style: "display:none", autocomplete: "off"
    end
  end
end
