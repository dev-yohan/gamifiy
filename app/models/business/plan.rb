class Business::Plan
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String
  slug :name

  field :description, type: String

  field :apps_available, type: Integer

  field :logo, type: String
  mount_uploader :logo, SiteImageUploader


  has_many :users, :class_name => "User"

end
