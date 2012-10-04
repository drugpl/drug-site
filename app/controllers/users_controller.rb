class UsersController < ApplicationController
  def index
    sorter = KarmaCounter.new
    @users = User.all.sort_by{|u| sorter.karma(u) }
  end

  def show
  end
end
