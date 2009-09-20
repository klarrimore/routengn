HISTFILE = "~/.routengn.irb.hist"
MAXHISTSIZE = 1000

if defined? Readline::HISTORY
  histfile = File.expand_path(HISTFILE)
  if File.exists?(histfile)
    lines = IO.readlines(histfile).collect { |line| line.chomp }
    Readline::HISTORY.push(*lines)
  end

  Kernel.at_exit do
    lines = Readline::HISTORY.to_a.reverse.uniq.reverse
    lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.nitems > MAXHISTSIZE
    File.open(histfile, File::WRONLY|File::CREAT|File::TRUNC) do |f|
      lines.each { |line| f.puts line }
    end
  end
end
