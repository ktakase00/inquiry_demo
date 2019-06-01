module Registrar::Adapter
  # 外部サービスアダプター：ヘルプデスク用
  class HelpDesk
    include Registrar::Adapter::Base

    # 実行
    # @return [Hash] 受付コードとエラーを持つハッシュ
    def execute
      # 外部サービスへアクセス
      ex_service = ExService::HelpDesk.new
      res = ex_service.create(@inquiry_content)

      # 返却値を生成
      case res[:code]
      when ExService::HelpDesk::CODE_SUCCESS
        { accept_cd: res[:body][:ident], error: nil }
      else
        { accept_cd: nil, error: res }
      end
    end
  end
end
