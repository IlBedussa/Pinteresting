class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :pin
  validates :user_id, presence: true
  validates :pin_id, presence: true
  validates_uniqueness_of :user_id, :scope => :pin_id
end
