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

  [:name, :email, :username, :website, :github, :twitter, :bio].each do |method_name|
    define_method method_name do
      if user.send("#{method_name}?")
        user.send(method_name)
      else
        "No #{method_name} given"
      end
    end
  end

  def method_missing(method_name, *args, &block)
    user.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    user.respond_to?(method_name, include_private) || super
  end
end
