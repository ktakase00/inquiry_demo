module Registrar
  # 外部サービスアダプターファクトリー
  class AdapterFactory
    # アダプターの定義
    ADAPTER_MAP = {
      Const::InquiryCd::SALES => Registrar::Adapter::Sales,
      Const::InquiryCd::HELP_DESK => Registrar::Adapter::HelpDesk,
      Const::InquiryCd::TECH_FORUM => Registrar::Adapter::TechForum,
    }

    # 初期化
    # @param inquiry_cd [String] 問い合わせコード
    # @param inquiry_content [String] 問い合わせ内容
    def initialize(inquiry_cd, inquiry_content)
      @inquiry_cd = inquiry_cd
      @inquiry_content = inquiry_content
    end

    # アダプター生成
    def create
      ADAPTER_MAP[@inquiry_cd].new(@inquiry_content)
    end
  end
end
