module Crafter
  @@instance_cache = nil

  def self.instance_cache
    @@instance_cache
  end

  def self.instance_cache=(instance_cache)
    @@instance_cache = instance_cache
  end

  class Instance
    attr_accessor :craftfile

    def initialize(name)
      @craftfile = Crafter::FileSystem.instance_directory(name)[:craftfile]
    end

    def delete
      InstanceCache.burst(self)
    end
  end

  class InstanceCache
    def initialize()
      @instances = [] # It's super effective!
    end

    def load
      Crafter.instance_cache =
        Marshal.load(File.read(Crafter::FileSystem.instance_cache_location))
    end

    def save
      File.open(Crafter::FileSystem.instance_cache_location, "w")
        { |f| f.write(Marshal.dump(self)) }
    end

    def burst(instance = nil)
      if instance
        @instances.delete(instance)
        recalculate_instance_cache(instance.name)
      else
        @instances = []
        recalclate_all_instance_caches
      end
    end

    def find(name)

    end

    private

    def recalculate_instance_cache(instance_name)
      # Recalculate it
    end

    def recalculate_all_instance_caches
      Crafter::FileSystem.fs_instance_list.
        each { |e| recalculate_instance_cache(e) }
    end
  end
end
