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

  def keep_upcoming_event_alive
    if Event.upcoming.blank?
      last_happened = Event.happened.last

      event = Event.new
      event.venue = last_happened.venue
      event.description = last_happened.description
      event.starting_at = third_monday_of_next_month(last_happened.starting_at)

      event.title = "DRUG #"
      event.title += (last_happened.title.scan(/(\w+)/).last.first.to_i + 1).to_s

      event.save!

      last_happened.postponed_presentations.each do |postponed_presentation|
        new_presentation = postponed_presentation.dup
        new_presentation.event = event
        new_presentation.status = 'submitted'
        new_presentation.save!
      end
    end
  end

private
  def third_monday_of_next_month(date)
    new_date = DateTime.new(date.year, date.month, 1, date.hour)
    new_date += 1.month
    new_date += 1 until new_date.monday?
    new_date += 2.weeks
  end
end