module Registrar::Adapter
  # アダプターの共通処理
  # ※オブジェクト指向ポイント3:
  #   各アダプターから共通処理を切り出し、個別の機能のソースコードを差分のみとする
  #   (継承またはmixin)
  module Base
    # 初期化
    # @param inquiry_content [String] 問い合わせ内容
    def initialize(inquiry_content)
      @inquiry_content = inquiry_content
    end
  end
end
