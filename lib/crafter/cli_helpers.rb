module Crafter
  module CLIHelpers
    #
    # Say something! Use § characters around parts of text you have colorized
    # @param *args [String] Arguments to pass to #low_say
    # @param bold: true [Boolean] Enable or disable auto-bolding
    # @param force_new_line: false [Boolean] Force new line?
    def say(*args, superify: false, bold: true, force_new_line: false)
      return super *args if superify
      arrow(colors: :blue)
      low_say(*args, bold: bold, force_new_line: force_new_line)
    end

    #
    # Asks for information from the user.
    # @param message [String] Message to provide.
    # @param valid: [] [Array<String>] Valid options.
    #   An empty array will be ignored.
    #
    # @return [String] User response.
    def ask(message, valid: [], bold: true, force_new_line: false)
      return loop_valid(message, valid) unless valid.empty?
      stringify_message!(message); arrow(colors: :blue)
      message << "\n    > "
      low_say(message, bold: bold, force_new_line: force_new_line)
      STDIN.gets
    end

    def say_error(message)
      arrow(colors: :red)
      low_say(message, colors: :red)
    end

    def from_to_message(from, to, source: nil)
      "(#{source.dup << ' ' unless source.empty?}"\
      "§#{from.underline}§ -> §#{to.underline}§)"
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

    def low_say(message, colors: [], bold: true, force_new_line: nil)
      stringify_message!(message)
      message = generate_bold_text(message) if bold
      conditional_arg!(args = [], force_new_line)
      say(message, colors, *args, superify: true)
    end

    def generate_bold_text(text)
      if text.scan('§').length % 2 == 1
        raise "There must be an even number of §'s in the message: #{text}"
      end

      text.split('§').map do |string|
        string.colorized? ? string : string.bold
      end.join
    end

    def arrow(colors: [])
      low_say('==> ', bold: false, colors: colors)
    end

    def stringify_message!(message)
      message = [message].flatten.join("\n    ")
    end
  end
end
