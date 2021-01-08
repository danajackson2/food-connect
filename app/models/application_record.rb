class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  def username_unique
    if self.id == nil
      if all_users.map{|u|u.username}.include?(self.username)
        errors.add(:Username, "is already taken")
      end
    end
  end

  def all_users
    Volunteer.all + FoodBank.all
  end
end
