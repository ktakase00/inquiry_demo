class Inquiry < ApplicationRecord
  validates :inquiry_cd, presence: true
  validates :inquiry_content, presence: true

  before_create do
    self.inquiry_at = Time.now if self.inquiry_at.blank?
  end

  # 登録に成功したか
  def success?
    self.error_json.blank?
  end
end
