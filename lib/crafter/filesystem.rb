module Crafter
  class FileSystem
    CRAFTER_DIR = "#{ENV['HOME']}/.crafter"

    def self.create_folder_structure
      Dir.mkdir CRAFTER_DIR unless Dir.exist? CRAFTER_DIR
      Dir.mkdir "#{CRAFTER_DIR}/versions" unless Dir.exist? "#{CRAFTER_DIR}/versions"
      Dir.mkdir "#{CRAFTER_DIR}/instances" unless Dir.exist? "#{CRAFTER_DIR}/instances"
    end

    def self.create_instance_folder(name, options = {})
      Dir.mkdir "#{CRAFTER_DIR}/instances/#{name}" unless Dir.exist? "#{CRAFTER_DIR}/instances/#{name}"
    end
  end
end