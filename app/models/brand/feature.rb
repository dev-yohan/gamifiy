class Brand::Feature
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  field :description, type: String
  field :published, type: Boolean

     


end
