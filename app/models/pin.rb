class Pin < ActiveRecord::Base
	belongs_to :user
	has_many :likes, :dependent => :destroy
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }
	# validates :image, presence: true
	validates :description, presence: true
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  after_create :add_defaults
  MESSAGES = ["Wish you a very happy birthday David!", "Many Many happy returns of the day David!", "Have a great Birthday David!", "Here’s to lots of celebration today! We wish you lots of good health for you and your loved ones in the coming year :)", "Remember this wise saying on your happy day: the more you celebrate your life, the more there is in life to celebrate!", "Have a wonderful happy, healthy birthday and many more to come. Happy Birthday!"]
  IMAGES = ["https://www.dropbox.com/sh/7d56haqvth6edhr/AACZtaBnMf02i6l8MZ0zdqNGa/1ff2b5e340ff1c34aaab91e9b22f5b526e75858bd86687409e608ab815799a6d.jpg?dl=0",
            "https://www.dropbox.com/s/wxo0rmbuxzk8kj7/1ff2b5e340ff1c34aaab91e9b22f5b526e75858bd86687409e608ab815799a6d.jpg?dl=0",
            "https://www.dropbox.com/s/vc9un6geffylumw/5e96398e4f502e82a1acebe3083b1fda.jpg?dl=0",
            "https://www.dropbox.com/s/a4mm0yidgocpa0l/Blackjack%2012.jpg?dl=0"]
  
  def add_defaults
    self.description = MESSAGES.sample if self.description.blank?
    self.image = open(IMAGES.sample) if self.image.blank?
    self.save!
  end
end
