class Activity
  include Mongoid::Document
  field :name, type: String
  field :description, type: String

  belongs_to :site, :class_name => "Sites::Site"

end
