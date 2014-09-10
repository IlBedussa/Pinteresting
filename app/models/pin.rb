# -*- coding: utf-8 -*-
class Pin < ActiveRecord::Base
	belongs_to :user
	has_many :likes, :dependent => :destroy
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	# validates :image, presence: true
	# validates :description, presence: true
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  before_save :add_defaults
  default_scope {where("user_id is not null")}
  MESSAGES = ["Wish you a very happy birthday David!", "Many Many happy returns of the day David!", "Have a great Birthday David!", "Here’s to lots of celebration today! We wish you lots of good health for you and your loved ones in the coming year :)", "Remember this wise saying on your happy day: the more you celebrate your life, the more there is in life to celebrate!", "Have a wonderful happy, healthy birthday and many more to come. Happy Birthday!"]
  
  def add_defaults
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    self.description = MESSAGES.sample if self.description.blank?
    puts "###########################################"
    self.image = open Pin.unscoped.where("user_id is null").to_a.sample.image(:medium)  if self.image.blank?
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end
  
  def self.create_defaults
    (1..32).to_a.each do |i|
      Pin.create
    end
  end
end
