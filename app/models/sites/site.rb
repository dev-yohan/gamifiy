class Sites::Site
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  slug :name

  field :logo, type: String
  mount_uploader :logo, SiteImageUploader

  belongs_to :user, :class_name => "User"
  

end