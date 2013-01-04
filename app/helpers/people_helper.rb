module PeopleHelper
  def facebook_profile_url(person)
    if person.facebook_uid.present?
      link_to image_tag('glyphicons_320_facebook.png', size: "16x16"),
        "http://facebook.com/#{person.facebook_uid}"
    end
  end

  def github_profile_url(person)
    if person.github_uid.present? && person.github_nickname.present?
      link_to image_tag('glyphicons_341_github.png', size: "16x16"),
        "http://github.com/#{person.github_nickname}"
    end
  end

  def rss_url(person)
    if person.rss_url.present?
      link_to image_tag('glyphicons_327_rss.png', size: "16x16"), person.rss_url
    end
  end

  def profiles_auth_links(person)
    blank_providers = ['github', 'facebook'].select do |provider|
      person.send("#{provider}_uid").blank?
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

  def facebook_avatar_url(person)
    "http://graph.facebook.com/#{person.facebook_uid}/picture?type=square"
  end

  def gravatar_avatar_url(person, size, default_url)
    gravatar_id = Digest::MD5::hexdigest(person.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
  end

  def avatar_url(person, size = 64)
    # default_url = root_url + asset_path("avatar.png")
    default_url = "http://userserve-ak.last.fm/serve/_/27372765/MrT.jpg"
    return facebook_avatar_url(person) if person.facebook_uid?
    return gravatar_avatar_url(person, size, default_url) if person.email?
    default_url
  end
end
