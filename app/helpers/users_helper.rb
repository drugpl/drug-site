module UsersHelper
  def facebook_profile_url(user)
    if user.facebook_uid.present?
      link_to image_tag('glyphicons_320_facebook.png', size: "16x16"),
        "http://facebook.com/#{user.facebook_uid}"
    end
  end

  def github_profile_url(user)
    if user.github_uid.present?
      link_to image_tag('glyphicons_341_github.png', size: "16x16"),
        "http://github.com/#{user.github_uid}"
    end
  end

  def twitter_profile_url(user)
    if false
      link_to image_tag('glyphicons_322_twitter.png', size: "16x16"),
        "http://twitter.com/#!/#{id}"
    end
  end

  def rss_url(user)
    if false
      link_to image_tag('glyphicons_327_rss.png', size: "16x16"), ""
    end
  end
end
