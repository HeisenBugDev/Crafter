module Crafter
  module CLIOverrides
    def say(*args, superify: false)
      return super *args if superify
      arrow(colors: :blue); low_say(*args)
    end

    #
    # Asks for information from the user.
    # @param message [String] Message to provide.
    # @param valid: [] [Array<String>] Valid options.
    #   An empty array will be ignored.
    #
    # @return [String] User response.
    def ask(message, valid: [])
      return loop_valid(message, valid) unless valid.empty?
      stringify_message!(message); arrow(colors: :blue)
      message << "\n    > "
      low_say(message)
      STDIN.gets
    end

    def say_error(message)
      arrow(colors: :red)
      low_say(message, colors: :red)
    end

  private

    def loop_valid(message, valid)
      valid.map!(&:to_s)
      loop do
        response = ask("#{message} #{valid.to_s.delete('"')}")
        return response if valid.include? response.downcase.strip
        say_error('Invalid choice')
      end
    end

    # Adds argument to array if it is truthy
    def conditional_arg!(args_array, arg)
      args_array << arg if arg
    end

    def low_say(message,
    colors: [], arrow_color: nil, bold: true, force_new_line: nil)
      stringify_message!(message)
      conditional_arg!(args = [], force_new_line)
      colors = ([colors] << (:bold if bold)).flatten.compact
      say(message, colors, *args, superify: true)
    end

    def arrow(colors: [])
      low_say('==> ', bold: false, colors: colors)
    end

    def stringify_message!(message)
      message = [message].flatten.join("\n    ")
    end
  end
end
