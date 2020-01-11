require "rake/testtask"

# desc "Run tests."
# Rake::TestTask.new :test do |t|
#   t.test_files = FileList["**/test/**/*_test.rb"]
#   t.warning = false
# end


# Rake::TestTask.new :acceptance do |t|
#   t.test_files = FileList["**/acceptance/**/*_test.rb"]
#   t.warning = false
# end

task :thing do
  puts dirs
end

task :test do
  each_product do |product, dir|
    header "Running tests for #{product}"
    test_task dir, "test"
  end
end

task :acceptance do
  # ruby -Ilib:test storage/acceptance/files_test.rb
  each_product do |product, dir|
    header "Running tests for #{product}"
    test_task dir, "test"
    test_task dir, "acceptance"
  end
end

def each_product
  dirs.each do |dir|
    Dir.chdir dir do
      Bundler.with_clean_env do
        sh "bundle install"
        product = dir.split("ruby-docs-samples/").last
        yield product, dir
      end
    end
  end
end

def test_task dir, type
  Rake::TestTask.new "#{dir}_#{type}" do |t|
    t.test_files = FileList["#{dir}/#{type}/**/*_test.rb"]
    t.warning = false
  end
  Rake::Task["#{dir}_#{type}"].invoke
end

def dirs
  entries = Dir.glob("#{__dir__}/**/*_test.rb").map do |entry|
    File.expand_path "..", File.dirname(entry)
  end
  entries.uniq
end

def header str, token = "#"
  line_length = str.length + 8
  puts ""
  puts token * line_length
  puts "#{token * 3} #{str} #{token * 3}"
  puts token * line_length
  puts ""
end

def header_2 str, token = "#"
  puts "\n#{token * 3} #{str} #{token * 3}\n"
end
