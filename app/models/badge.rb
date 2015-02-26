class Badge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :name, type: String
  slug :name

  field :image, type: String
  mount_uploader :image, ImageUploader

  field :is_active, type: Boolean

  has_many :events, :class_name => "Event"
  belongs_to :site, :class_name => "Sites::Site"

  before_destroy :destroy_events

  def destroy_events
    if !self.events.nil? && self.events.count > 0
      self.events.destroy
    end  
  end

end
