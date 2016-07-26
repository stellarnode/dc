class Post < ApplicationRecord
  	belongs_to 				:user
  	validates_presence_of 	:title, :body, :user_id
	scope 					:published, -> { where(is_draft: false) }
	scope 					:draft, -> { where(is_draft: true) }
  	scope 					:news, 		-> { where(is_pinned: true) }

  	acts_as_commontable
end
