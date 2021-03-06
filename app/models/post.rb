class Post < ApplicationRecord
  belongs_to 					             :user
  has_many						             :post_categories, dependent: :destroy
  has_many						             :categories, through: :post_categories
  accepts_nested_attributes_for 	 :post_categories, allow_destroy: true, reject_if: :all_blank

  validates_presence_of :title, :body, :user_id

	scope 							:published,    -> { where(is_draft: false) }
	scope 							:draft, 	     -> { where(is_draft: true) }
  scope 							:news, 		     -> { where(is_pinned: true) }

  # Use roles with this model
  resourcify

  # Set comments to Post
  acts_as_commentable

  # Set number of posts per page
  paginates_per 10

  # Use CarrierWave image uploader
  mount_uploaders :images, ImageUploader

  #Helper method for Active Admin
  def display_name
    self.title.truncate(40, separator: ' ')
  end

end
