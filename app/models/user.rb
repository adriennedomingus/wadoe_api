class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_uniqueness_of :api_key

  def generate_api_key
    self.update(api_key: SecureRandom.hex)
  end
end
