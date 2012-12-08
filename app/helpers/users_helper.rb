module UsersHelper
  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    elsif user.email.present?
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=80"
    else
      image_path "blank_avatar.png"
    end
  end
end
