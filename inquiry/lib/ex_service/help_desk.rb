module ExService
  # 外部サービスAPI：ヘルプデスク用
  class HelpDesk
    CODE_SUCCESS = 0
    CODE_DUMMY_ERROR = 1

    # 受付コードを生成
    # @param inquiry_content [String] 問い合わせ内容
    # @return [Hash] 実行結果、codeとbodyを持つハッシュ
    def create(inquiry_content)
      # ダミーのエラー結果を返却する
      if /error/.match?(inquiry_content)
        return make_result_hash(CODE_DUMMY_ERROR, { message: 'error' })
      end

      # 受付番号を生成
      accept_no = ExAccept.increment(Const::InquiryCd::HELP_DESK)

      # 受付コードを返却
      # 例：{ code: 0, body: { ident: 'h001' } }
      make_result_hash(CODE_SUCCESS, { ident: make_code(accept_no) })
    end

    private

    # 受付番号から受付コードを生成
    def make_code(accept_no)
      "h%03d" % accept_no
    end

    # 返却値のハッシュを生成
    def make_result_hash(code, body)
      { code: code, body: body }
    end
  end
end
