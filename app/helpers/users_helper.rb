module UsersHelper
  def facebook_profile_url(user)
    if user.facebook_uid.present?
      link_to image_tag('glyphicons_320_facebook.png', size: "16x16"),
        "http://facebook.com/#{user.facebook_uid}"
    end
  end

  def github_profile_url(user)
    if user.github_uid.present? && user.github_nickname.present?
      link_to image_tag('glyphicons_341_github.png', size: "16x16"),
        "http://github.com/#{user.github_nickname}"
    end
  end

  def profiles_auth_links(user)
    blank_providers = ['github', 'facebook'].select do |provider|
      user.send("#{provider}_uid").blank?
    end.map do |provider|
      link_to provider, "/auth/#{provider}"
    end

    if blank_providers.present?
      "You can connect another services to your account: " + 
        blank_providers.to_sentence(two_words_connector: " or ", last_word_connector: ", or ") +
        "."
    else
      "You connected all services. Well done!"
    end
  end

  def avatar_url(user, size=64)
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    
    if user.facebook_uid.present?
      avatar_url = "http://graph.facebook.com/#{user.facebook_uid}/picture?type=square"
    end
    
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(avatar_url)}"
  end
end
