class UserDecorator
  attr_reader :user, :view_context

  def initialize(user, view_context)
    @user = user || User.new
    @view_context = view_context
  end

  def image
    if user.image_url?
      view_context.image_tag user.image_url
    else
      view_context.image_tag "http://placehold.it/200x200"
    end
  end

  def twitter_link
    if user.twitter?
      view_context.link_to "Twitter", user.twitter
    else
      view_context.link_to "Twitter", "http://twitter.com"
    end
  end

  [:name, :email, :username, :website,
   :github, :twitter, :bio].each do |method_name|

    define_method method_name do
      if user.send("#{method_name}?")
        user.send(method_name)
      else
        "No #{method_name} given"
      end
    end
  end

  def method_missing(name, *args, &block)
    user.send(name, *args, &block)
  end

  def respond_to_missing?(name, include_private = false)
    user.respond_to?(name, include_private) || super
  end
end
