module UsersHelper

  def avatar_url(user)
    if user.try(:avatar_url).present?
      user.try(:avatar_url)
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=80"
    end
  end

end
