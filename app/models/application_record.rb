class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def username_unique
    if all_users.map{|u|u.username}.include?(self.username)
      errors.add(:Username, "This username is already taken.")
    end
  end

  def all_users
    Volunteer.all + FoodBank.all
  end
end
