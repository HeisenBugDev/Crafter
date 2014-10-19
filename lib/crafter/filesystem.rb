module Crafter
  class FileSystem
    CRAFTER_DIR = File.join(Dir.home, '.crafter')

    class << self
      def base_directory
        Dir.mkdir CRAFTER_DIR unless Dir.exist? CRAFTER_DIR
        Dir.open CRAFTER_DIR
      end

      def versions_directory
        dir = crafter_folder('versions')
        Dir.mkdir dir unless Dir.exist? dir
        Dir.open dir
      end

      def instances_directory
        dir = crafter_folder('instances')
        Dir.mkdir dir unless Dir.exist? dir
        Dir.open dir
      end

      def instance_cache_location
        File.join(instances_directory, "InstanceCache")
      end

      def base_directory_structure
        [base_directory, versions_directory, instances_directory]
      end

      def fs_instance_list
        Dir.glob("#{instances_directory.to_path}/*").
          select { |f| File.directory? f }.
          map { |path| File.basename path }
      end

      def instance_directory(name)
        dir = crafter_folder('instances', name)
        Dir.mkdir(dir) unless Dir.exist?(dir)
        {dir: Dir.open(dir), craftfile: File.join(dir, 'Craftfile')}
      end

      def crafter_folder(*args)
        File.join(CRAFTER_DIR, *args)
      end
    end

  end
end