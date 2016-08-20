class Profile < ApplicationRecord
  belongs_to :user

  mount_uploader :avatar, AvatarUploader

  def full_name
    if self.first_name || self.middle_name || self.last_name
      [self.first_name, self.middle_name, self.last_name].join(" ")
    else
      'n/a'
    end
  end

end
