module Registrar
  # 問い合わせ登録窓口
  class Facade
    # 初期化
    # @param inquiry [Inquiry] モデル
    def initialize(inquiry)
      @inquiry = inquiry
    end

    # 実行
    def execute
      # 外部サービスアダプターを生成
      adapter_factory = Registrar::AdapterFactory.new(@inquiry.inquiry_cd, @inquiry.inquiry_content)
      adapter = adapter_factory.create

      # 外部サービスへの登録を実行
      # ※オブジェクト指向ポイント2:
      #   レジストラと外部サービスAPIの間にアダプターをはさみ、実行方法の違いを吸収する
      #   (多態性)
      result = adapter.execute

      # 実行結果を保存
      @inquiry.attributes = make_attributes(result)
      @inquiry.save!
    end

    private

    # 外部サービスの返却値からモデルにセットする属性の値を生成
    # @param result [Hash] 外部サービスの登録結果、受付コードとエラーを持つハッシュ
    # @return [Hash] inquiriesテーブルに保存する値を持つハッシュ
    def make_attributes(result)
      {
        accept_cd: result[:accept_cd].nil? ? '' : result[:accept_cd],
        error_json: result[:error].nil? ? {} : result[:error]
      }
    end
  end
end
