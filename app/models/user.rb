class User < ApplicationRecord
  has_secure_password

  def is_guest?
    false
  end
end
