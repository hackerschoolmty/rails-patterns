class NilUser
  def image_url
    "http://placehold.it/200x200"
  end

  def name
    "No name given"
  end

  def username
    "No username given"
  end

  def email
    "No email given"
  end

  def website
    "No website given"
  end

  def github
    "No github given"
  end

  def twitter
    "No twitter given"
  end

  def bio
    "No bio given"
  end

  def method_missing(name, *args, &block)
    false
  end

end
