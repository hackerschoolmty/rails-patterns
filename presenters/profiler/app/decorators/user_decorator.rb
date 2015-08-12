class UserDecorator
  attr_reader :user

  def initialize(user)
    @user = user
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
  end

  def email
    if user.email?
      user.email
    else
      "No email given"
    end
  end

  def website
    if user.website?
      user.website
    else
      "No website given"
    end
  end

  def github
    if user.github?
      user.github
    else
      "No github given"
    end
  end

  def twitter
    if user.twitter?
      user.twitter
    else
      "No twitter given"
    end
  end

  def bio
    if user.bio?
      user.bio
    else
      "No bio given"
    end
  end


  def method_missing(method_name, *args, &block)
    user.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    user.respond_to?(method_name, include_private) || super
  end
end
