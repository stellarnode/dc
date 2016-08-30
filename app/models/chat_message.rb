class ChatMessage < ApplicationRecord
  belongs_to :user

  #Helper method for Active Admin
  def display_name
    self.message.truncate(40, separator: ' ')
  end
end
