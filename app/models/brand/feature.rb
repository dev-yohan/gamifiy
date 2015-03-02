class Brand::Feature
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :description, type: String
  field :published, type: Boolean

  field :logo, type: String
  mount_uploader :logo, SiteImageUploader   


end
