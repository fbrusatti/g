class Photo < ActiveRecord::Base

  # == Associations
  belongs_to :property

  # == Accessors
  attr_accessible :image, :remove_image, :image_cache

  # == Mount
  mount_uploader :image, ImageUploader

  # == Validates
  validates_presence_of :image

  # == Callbacks
  after_destroy :remove_photo_directory

  private
    def remove_photo_directory
      folder_number = self.image.to_s.split("/")[4]
      path_to_be_deleted = "#{Rails.root}/public/uploads/photo/image/#{folder_number}"
      puts path_to_be_deleted
      FileUtils.remove_dir(path_to_be_deleted, force: true)
    end
end
