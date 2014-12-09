class Activity
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  
  field :name, type: String
  slug :name

  field :description, type: String
  field :is_active, type: Boolean

  belongs_to :site, :class_name => "Sites::Site"
  has_many :activity_logs, :class_name => "ActivityLog"

  field :activity_logs_count, type: Integer


end
