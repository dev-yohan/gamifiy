class Activity
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  field :site_id, type: Integer
end
