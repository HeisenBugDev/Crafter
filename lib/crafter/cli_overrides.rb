puts "LOAD"
module CLIOverrides
  def say(message, color: [], arrow_color: nil, bold: true, force_new_line: nil)
    # collapse_message!(message)
    puts "wat"
    [message].to_cli
    args = [force_new_line] if force_new_line
    super(message, *([color].flatten + ([:bold] if bold)), *args)
  end

  def ask(message, *args)
    collapse_message!(message)
    message << "\n    >"
    say('==> ', bold: false)
    super(message, )
  end

private

  def [](*args)
    CustomArray.new(message)
  end

  def collapse_message!(message)
    message = [message].flatten.join("\n    ")
  end

  class CustomArray << Array
    def to_cli
      [self].flatten.join("\n    ")
    end
  end
end
