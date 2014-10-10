module Crafter
  class FileSystem
    CRAFTER_DIR = "#{ENV['HOME']}/.crafter"

    def self.base_directory
      Dir.mkdir CRAFTER_DIR unless Dir.exist? CRAFTER_DIR
      Dir.open CRAFTER_DIR
    end

    def self.versions_directory
      dir = "#{CRAFTER_DIR}/versions"
      Dir.mkdir dir unless Dir.exist? dir
      Dir.open dir
    end

    def self.instances_directory
      dir = "#{CRAFTER_DIR}/instances"
      Dir.mkdir dir unless Dir.exist? dir
      Dir.open dir
    end

    def self.base_directory_structure
      [base_directory, versions_directory, instances_directory]
    end

    def self.instance_directory(name, options = {})
      dir = "#{CRAFTER_DIR}/instances/#{name}"
      Dir.mkdir dir unless Dir.exist? dir
      Dir.open dir
    end
  end
end