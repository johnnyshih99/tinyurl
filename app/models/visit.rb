class Visit < ApplicationRecord
  belongs_to :link

  validates :ip_addr, presence: true
end
