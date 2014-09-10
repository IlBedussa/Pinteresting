# -*- coding: utf-8 -*-
class Pin < ActiveRecord::Base
	belongs_to :user
	has_many :likes, :dependent => :destroy
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	# validates :image, presence: true
	# validates :description, presence: true
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  before_save :add_defaults
  MESSAGES = ["Wish you a very happy birthday David!", "Many Many happy returns of the day David!", "Have a great Birthday David!", "Here’s to lots of celebration today! We wish you lots of good health for you and your loved ones in the coming year :)", "Remember this wise saying on your happy day: the more you celebrate your life, the more there is in life to celebrate!", "Have a wonderful happy, healthy birthday and many more to come. Happy Birthday!"]
  
  def add_defaults
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    self.description = MESSAGES.sample if self.description.blank?
    puts "###########################################"
    self.image = open "http://www.iam21.today/default_images/#{(1..24).to_a.sample}.jpg"  if self.image.blank?
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  end
end
