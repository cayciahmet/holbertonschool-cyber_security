#!/usr/bin/env ruby

require 'open-uri'
require 'uri'
require 'fileutils'

# Check arguments
if ARGV.length != 2
  puts "Usage: 9-download_file.rb URL LOCAL_FILE_PATH"
  exit 1
end

url = ARGV[0]
local_path = ARGV[1]

begin
  puts "Downloading file from #{url}…"
  
  # Ensure the directory exists
  dir = File.dirname(local_path)
  FileUtils.mkdir_p(dir) unless Dir.exist?(dir)

  # Download and save the file
  URI.open(url) do |remote_file|
    File.open(local_path, "wb") do |file|
      file.write(remote_file.read)
    end
  end

  puts "File downloaded and saved to #{local_path}."
rescue StandardError => e
  puts "Failed to download file: #{e.message}"
end
