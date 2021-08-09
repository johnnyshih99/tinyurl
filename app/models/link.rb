class Link < ApplicationRecord
  has_many :visits
  validates :token, presence: true
  validates :token, uniqueness: true
  validate :url_format

  def url_format
    if url.blank?
      errors.add(:url, "can't be blank")
    else
      uri = URI.parse(url)
      if uri.host.nil?
        errors.add(:url, "Invalid format")
      end
    end
  end
end
