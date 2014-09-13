module Crafter

  class CraftfileError < RuntimeError; end
  class DSL

    def initialize

    end

    def eval_craftfile(craftfile, contents = nil)
      contents ||= File.open(craftfile, 'rb') do |file|
        file.read
      end
      instance_eval(contents, craftfile.to_s, 1)
    rescue SyntaxError => error
      message = error.message.split('\n')[1..-1]
      raise CraftfileError, ['Craftfile syntax error:' *message].join('\n')
    rescue ScriptError, RegexpError, NameError, ArgumentError => error
      error.backtrace[0] = "#{error.backtrace[0]}: #{error.message} (#{error.class})"
      SRDERR.puts error.backtrace.join('\n           ')
      raise CraftfileError, 'There was an error in your Craftfile, and Crafter cannot continue.'
    end

    def minecraft(version)

    end

    def forge(version)

    end

    # Only applicable to Minecraft < 1.8
    def bukkit(version)

    end

    # Only applicable to Minecraft < 1.8
    def cauldron(version)

    end

    def canary(version)

    end

    # Only applicable to Minecraft > 1.8
    def sponge(version)

    end

    # Only applicable to Minecraft < 1.6.4, I think...
    def spout(version)

    end

    # Old Server Mod...
    def hmod(version)

    end

    alias_method :mcpc, :cauldron
    alias_method :mcpc_plus, :cauldron

    def source(location, options = {})

    end

    def mod(name, *args)

    end

    def resource_pack(name, options = {})

    end

    alias_method :rp, :resource_pack

  end

end