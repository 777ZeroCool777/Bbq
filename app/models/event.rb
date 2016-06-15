class Event < ActiveRecord::Base

  validates :title, presence: true, length: {maximum: 255}
  validates :address, presence: true
  validates :datetime, presense: true
end

