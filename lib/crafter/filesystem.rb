module Crafter
  class FileSystem
    def self.create_crafter_directory
      Dir.mkdir "#{ENV['HOME']}/.crafter/" unless Dir.exist? "#{ENV['HOME']}/.crafter"
    end
  end
end