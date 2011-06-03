class AttachmentUploader < CarrierWave::Uploader::Base
 
  # Include RMagick or ImageScience support
  #     include CarrierWave::RMagick
  #     include CarrierWave::ImageScience
 
  # Choose what kind of storage to use for this uploader
  storage :s3
 
  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
 
  # Provide a default URL as a default if there hasn't been a file uploaded
  #     def default_url
  #       "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  #     end
 
  # Process files as they are uploaded.
  #     process :scale => [200, 300]
  #
  #     def scale(width, height)
  #       # do something
  #     end
 
  # Create different versions of your uploaded files
  #     version :thumb do
  #       process :scale => [50, 50]
  #     end
 
 
  # Override the filename of the uploaded files
  #     def filename
  #       "something.jpg" if original_filename
  #     end
  def cache_dir
    "#{Rails.root}/tmp/uploads" # for heroku read-only filesystem
                                # see http://codingfrontier.com/carrierwave-on-heroku
  end
  
  def extension_white_list
    %w(pgn)
  end
 
end
