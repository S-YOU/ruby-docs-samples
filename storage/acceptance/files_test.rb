require_relative "helper"
require_relative "../files.rb"

describe "Storage Files Snippets" do
  before do
    @bucket_name = "ruby_storage_sample_#{SecureRandom.hex}"
    @client = Google::Cloud::Storage.new
    delete_bucket @bucket_name
    @bucket = @client.create_bucket @bucket_name
    @local_file = File.expand_path "data/file.txt", __dir__
  end

  after do
    delete_bucket @bucket_name
  end

  describe "list_bucket_contents" do
    it "puts the bucket's contents" do
      @bucket.create_file @local_file, "foo.txt"
      @bucket.create_file @local_file, "bar.txt"
      out, _err = capture_io do
        list_bucket_contents bucket_name: @bucket_name
      end
      assert_match /foo.txt/, out
      assert_match /bar.txt/, out
    end
  end

  describe "list_bucket_contents_with_prefix" do
    it "puts the bucket's contents that begin with the prefix" do
      ["foo/file.txt", "foo/data.txt", "bar/file.txt","bar/data.txt"].each do |file|
        @bucket.create_file @local_file, file
      end
      out, _err = capture_io do
        list_bucket_contents_with_prefix bucket_name: @bucket_name, prefix: "foo/"
      end
      assert_match "foo/file.txt", out
      assert_match "foo/data.txt", out
    end

    it "omits the bucket's contents that don't begin with the prefix" do
      ["foo/file.txt", "foo/data.txt", "bar/file.txt","bar/data.txt"].each do |file|
        @bucket.create_file @local_file, file
      end
      out, _err = capture_io do
        list_bucket_contents_with_prefix bucket_name: @bucket_name, prefix: "foo/"
      end
      refute_match "bar/file.txt", out
      refute_match "bar/data.txt", out
    end
  end

  describe "generate_encryption_key_base64" do
    
  end


end
