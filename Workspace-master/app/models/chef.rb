class Chef < ActiveRecord::Base

  before_save { self.email = email.downcase }

  has_many :recipes
  has_many :likes
  has_many :comments

  VALID_EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates :email, presence: true, length: { minimum: 5, maximum: 30 },
                                    uniqueness: { case_sensitive:false }
  validates_format_of :email,:with => VALID_EMAIL_REGEX

  has_secure_password

  mount_uploader :picture, PictureUploader
  validate :picture_size

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "Image too large, it should be less than 5MB")
    end
  end

end