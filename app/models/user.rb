class User < ApplicationRecord
  has_secure_password

  has_many :articles

  def is_guest?
    false
  end
end
