CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :s3
    config.s3_access_key_id = 'AKIAIM4FSUC2GORGIQYA'
    config.s3_secret_access_key = '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'
    config.s3_bucket = 'albertorecurso'
    config.s3_headers = {'Cache-Control' => 'max-age=315576000',
       'Expires' => 99.years.from_now.httpdate}
  elsif Rails.env.development?
    config.storage = :file
  else
    config.storage = :file
  end
end
