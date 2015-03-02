class Brand::Screenshot
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :description, type: String
  field :published, type: Boolean

  field :image, type: String
  mount_uploader :image, SiteImageUploader

end
