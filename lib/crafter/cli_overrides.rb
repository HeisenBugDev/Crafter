puts "wut"

module Crafter
  module CLIOverrides
    def low_say(message,
    colors: [], arrow_color: nil, bold: true, force_new_line: nil)
      stringify_message!(message)
      conditional_arg(args = [], force_new_line)
      colors = ([colors] << (:bold if bold)).compact
      say(message, colors, *args, superify: true)
    end

    def say(*args, superify: false)
      return super *args if superify
      arrow; low_say(*args)
    end

    def ask(message, *args)
      stringify_message!(message); arrow
      message << "\n    >"
      super(message, )
    end

  private

    # Adds argument to array if it is truthy
    def conditional_arg!(args_array, arg)
      args_array << arg if arg
    end

    def arrow
      low_say('==> ', bold: false)
    end

    def stringify_message!(message)
      message = [message].flatten.join("\n    ")
    end
  end
end
