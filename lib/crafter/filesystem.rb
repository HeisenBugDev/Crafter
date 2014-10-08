module Crafter
  class FileSystem
    def self.create_folder_structure
      crafter_dir = "#{ENV['HOME']}/.crafter/"
      Dir.mkdir crafter_dir unless Dir.exist? crafter_dir
      Dir.mkdir "#{crafter_dir}/versions" unless Dir.exist? "#{crafter_dir}/versions"
      Dir.mkdir "#{crafter_dir}/instances" unless Dir.exist? "#{crafter_dir}/instances"
    end
  end
end