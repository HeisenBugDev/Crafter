module CLIOverrides
  def low_say(message, color: [], arrow_color: nil, bold: true, force_new_line: nil)
    collapse_message!(message)
    args = [force_new_line] if force_new_line
    colors = ([color] << (:bold if bold)).flatten.compact
    say(message, colors, *args, superify: true)
  end

  def say(*args, superify: false)
    return super *args if superify
    arrow; low_say(*args)
  end

  def ask(message, *args)
    collapse_message!(message); arrow
    message << "\n    >"
    super(message, )
  end

private

  def arrow
    low_say('==> ', bold: false)
  end

  def collapse_message!(message)
    message = [message].flatten.join("\n    ")
  end
end
