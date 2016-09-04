class GuestUser < User

  def initialize(opts={})
    super
    self.username = 'Guest'
  end

  def is_guest?
    true
  end

end