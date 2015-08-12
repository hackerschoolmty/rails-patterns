class UserDecorator
  attr_reader :user

  def initialize(user)
    @user = user || NilUser.new
  end

  def image_url
    if user.image_url?
      user.image_url
    else
      "http://placehold.it/200x200"
    end
  end

  def name
    if user.name?
      user.name
    else
      "No name given"
    end
  end

  def username
    if user.username?
      user.username
    else
      "No username given"
    end
  else
    "No username given"
  end

  def email
    if user.email?
      user.email
    else
      "No email given"
    end
  else
    "No email given"
  end

  def website
    if user.website?
      user.website
    else
      "No website given"
    end
  else
    "No website given"
  end

  def github
    if user.github?
      user.github
    else
      "No github given"
    end
  else
    "No github given"
  end

  def twitter
    if user.twitter?
      user.twitter
    else
      "No twitter given"
    end
  else
    "No twitter given"
  end

  def bio
    if user.bio?
      user.bio
    else
      "No bio given"
    end
  else
    "No bio given"
  end


  def method_missing(method_name, *args, &block)
    user.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    user.respond_to?(method_name, include_private) || super
  end
end
