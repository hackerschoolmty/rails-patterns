class User
  attr_accessor :name
end

class NilUser

  def name
    'no name'
  end

  def email
    'no email'
  end
end

class JobTitle

  def initialize(user)
    @user = user || NilUser.new
  end

  def user_name
    user.name
  end

  def user_email
    user.email
  end

end
