module Registrar::Adapter
  # 外部サービスアダプター：営業用
  class Sales
    include Registrar::Adapter::Base

    # 実行
    # @return [Hash] 受付コードとエラーを持つハッシュ
    def execute
      begin
        # 外部サービスへアクセス
        ex_service = ExService::Sales.new
        res = ex_service.register(@inquiry_content)

        # 返却値を生成
        { accept_cd: res[:code], error: nil }

      rescue => e
        { accept_cd: nil, error: { message: e.message } }
      end
    end
  end
end
