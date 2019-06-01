module ApplicationHelper

  # モデル名と操作で「お問い合わせ新規登録」などの文字列を生成する
  # @param model_cd [String] inquiryなどのモデル名を表すアンダースコア区切りの文字列
  # @param action_cd [String] newなどの操作を表す文字列
  # @return [String] 「お問い合わせ新規登録」などの文字列
  def i18n_model_action(model_cd, action_cd)
    I18n.t('app.model_action', {
      model: I18n.t("activerecord.models.#{model_cd}"),
      action: I18n.t("app.#{action_cd}")
    })
  end

  # 訳語の定義からselectタグの選択肢を表すパラメータを生成する
  # @param attr [String] 訳語が定義されている属性の名前
  # @param default_flag [Boolean] 選択肢の先頭に未選択の項目を追加するか
  # @return [Array<Array<String, String>>] ['表示名', '値']の配列
  def make_const_options(attr, default_flag: true)
    attr_hash = I18n.t("const.#{attr}")
    options = attr_hash.keys.sort.map do |key|
      [attr_hash[key], key]
    end
    options.unshift([I18n.t('app.not_selected'), '']) if default_flag
    options
  end

  # オブジェクトを表示用にJSON文字列に変換する
  # @param obj [Object] 表示対象のオブジェクト
  # @return [String] 画面に表示するJSON文字列
  def display_json(obj)
    obj.blank? ? '' : JSON.generate(obj)
  end

  # 改行を含む文字列を表示するためのHTMLを生成する
  # content [String] 表示対象の文字列
  # @return [String] 改行文字をbrタグに返還した文字列
  def display_multiline(content)
    return '' if content.nil?
    safe_join(content.split("\n"), tag.br)
  end
end
