module Crafter
  @@instance_cache = nil

  def self.instance_cache
    @@instance_cache
  end

  def self.instance_cache=(instance_cache)
    @@instance_cache = instance_cache
  end

  class Instance
    attr_reader :craftfile
    attr_reader :name
    attr_reader :mods

    def initialize(name)
      @mods = []
      @name = name
      @craftfile = Crafter::FileSystem.instance_directory(name)[:craftfile]
      InstanceCache.register_instance(self)
    end

    def add_mod(mod)
      @mods << mods unless @mods.include? mod
    end

    def self.create(name)
      instance = InstanceCache.find(name)
      instance || self.new(name)
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
      find_by(:name, name)
    end

    def find_by(key, value)
      @instances.find { |instance| instance.send(key) == value }
    end

    def register_instance(instance)
      @instances << instance
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
