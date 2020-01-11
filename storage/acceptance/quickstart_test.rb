require_relative "helper"
require_relative "../quickstart.rb"

describe "Storage Quickstart" do
  before do
    @bucket_name = "ruby_storage_sample_#{SecureRandom.hex}"
    @client = Google::Cloud::Storage.new
    delete_bucket @bucket_name
  end

  after do
    delete_bucket @bucket_name
  end

  it "creates a new bucket" do
    quickstart bucket_name: @bucket_name
    assert @client.bucket @bucket_name
  end

  it "puts the bucket name" do
    assert_output(/Bucket #{@bucket_name} was created./) { quickstart bucket_name: @bucket_name }
  end
end
