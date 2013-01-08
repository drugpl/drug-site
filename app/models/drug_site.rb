class DrugSite
  def omniauth_authenticate(user, auth, provider=nil)
    if user.present?
      previous_account = Person.where("#{auth.provider}_uid" => auth.uid).first
      user.move_legacy_from(previous_account) unless previous_account.nil?
      user.add_omniauth_properties(auth)
    elsif provider.present?
      user = Person.from_omniauth(auth)
    end
    user.id
  end
end