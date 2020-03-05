class Note < ActiveRecord::Base
  validates :content, presence: true, length: { in: 25..2000 }
  validates :email, email: true, allow_blank: true
end
