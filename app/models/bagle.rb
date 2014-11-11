class Bagle
  include Mongoid::Document
  mount_uploader :image, ImageUploader
  
  field :name, type: String
  field :image, type: String
end
