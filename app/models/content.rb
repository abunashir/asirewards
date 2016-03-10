class Content < ActiveRecord::Base
  belongs_to :certificate
  mount_uploader :banner, BannerUploader
end
