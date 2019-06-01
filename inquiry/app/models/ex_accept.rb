class ExAccept < ApplicationRecord
  # 各外部サービスの受付数を1件増やして新しい番号を返却する
  def self.increment(inquiry_cd)
    ex_accept = self.find_by({ inquiry_cd: inquiry_cd })
    ex_accept.accept_count += 1
    ex_accept.save
    ex_accept.accept_count
  end
end
