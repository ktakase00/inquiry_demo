module ExService
  # 外部サービスAPI：営業用
  class Sales
    # 受付コードを生成
    # @param inquiry_content [String] 問い合わせ内容
    # @return [Hash] 実行結果、codeを持つハッシュ
    def register(inquiry_content)
      # ダミーの例外を発生させる
      raise 'error' if /error/.match?(inquiry_content)

      # 受付番号を生成
      accept_no = ExAccept.increment(Const::InquiryCd::SALES)

      # 受付コードを返却
      # 例：{ code: 's001' }
      { code: make_code(accept_no) }
    end

    private

    # 受付番号から受付コードを生成
    def make_code(accept_no)
      "s%03d" % accept_no
    end
  end
end
