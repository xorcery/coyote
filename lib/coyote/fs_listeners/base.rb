require 'digest'

module Coyote::FSListeners
  class Base
    attr_reader :last_event, :sha1_checksums_hash

    def initialize
      @sha1_checksums_hash = {}
      update_last_event
    end

    def update_last_event
      @last_event = Time.now
    end

    def modified_files(dirs, options = {})
      files = potentially_modified_files(dirs, options).select { |path| File.file?(path) && file_modified?(path) && file_content_modified?(path) }
      files.map! { |file| file.gsub("#{Dir.pwd}/", '') }
    end

    private

    def potentially_modified_files(dirs, options = {})
      match = options[:all] ? "**/*" : "*"
      Dir.glob(dirs.map { |dir| "#{dir}#{match}" })
    end

    def file_modified?(path)
      # Depending on the filesystem, mtime is probably only precise to the second, so round
      # both values down to the second for the comparison.
      File.mtime(path).to_i >= last_event.to_i
    rescue
      false
    end

    def file_content_modified?(path)
      sha1_checksum = Digest::SHA1.file(path).to_s
      if @sha1_checksums_hash[path] != sha1_checksum
        @sha1_checksums_hash[path] = sha1_checksum
        true
      else
        false
      end
    end
  end
end