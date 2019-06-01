module ExService
  # 外部サービスAPI：技術フォーラム用
  class TechForum
    # 受付コードを生成
    # @param inquiry_content [String] 問い合わせ内容
    # @return [Hash] 実行結果、codeとbodyを持つハッシュ
    def self.add_inquiry(inquiry_content)
      # ダミーの例外を発生させる
      raise 'error' if /error/.match?(inquiry_content)

      # 受付番号を生成
      accept_no = ExAccept.increment(Const::InquiryCd::TECH_FORUM)

      # 受付コードを返却
      # 例：{ code: 't001' }
      { code: make_code(accept_no) }
    end

    private

    # 受付番号から受付コードを生成
    def self.make_code(accept_no)
      "t%03d" % accept_no
    end
  end
end
