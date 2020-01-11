require "minitest/autorun"
require "securerandom"
require "google/cloud/storage"

def delete_bucket bucket_name
  storage = Google::Cloud::Storage.new
  bucket = storage.bucket bucket_name
  if bucket
    bucket.files.each &:delete
    bucket.delete
  end
end
