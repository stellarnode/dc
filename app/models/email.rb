class Email < ApplicationRecord
  belongs_to :user

  #Helper method for Active Admin
  def display_name
    self.subject.truncate(40, separator: ' ')
  end

end
