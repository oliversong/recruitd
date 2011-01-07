# Helpers added to this module are available in both controllers and views.
module SharedHelper

  def current_user?(user)
    logged_in? and user == current_user
  end
  
  # Return true if a user is connected to (or is) the current user
  def connected_to?(user)
    current_user?(user) or Connection.connected?(user, current_user)
  end
end
