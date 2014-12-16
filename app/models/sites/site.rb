require 'elasticsearch/model'
class Sites::Site
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  before_create :generate_access_token

  field :access_token, type: String
  
  field :name, type: String
  slug :name

  field :description, type: String

  field :logo, type: String
  mount_uploader :logo, SiteImageUploader

  belongs_to :user, :class_name => "User"
  has_many :activities, :class_name => "Activity", :dependent => "destroy"

  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end


  private
  
    def generate_access_token
      self.access_token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless self.class.where(access_token: random_token).nil?
      end
   end


end