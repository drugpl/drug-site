class DrugSite
  def omniauth_authenticate(user, auth, provider=nil)
    if user.present?
      previous_account = Person.where("#{auth.provider}_uid" => auth.uid).first
      move_legacy_from_to(previous_account, user) unless previous_account.nil?
      user.add_omniauth_properties(auth)
    elsif provider.present?
      user = Person.from_omniauth(auth)
    end
    user.id
  end

  def move_legacy_from_to(previous_account, new_account)
    new_account.irc_points += previous_account.irc_points
    new_account.presentations += previous_account.presentations
    new_account.events += previous_account.events
    
    if previous_account.irc_nickname.present? && new_account.irc_nickname.blank?
      new_account.irc_nickname = previous_account.irc_nickname 
    end

    if previous_account.github_uid.present?
      new_account.github_nickname = previous_account.github_nickname
    end

    new_account.save!
    previous_account.destroy
  end
end