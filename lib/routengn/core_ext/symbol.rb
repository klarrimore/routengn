class Symbol
  def camelize
    to_s.split(/[^a-z0-9]/i).map{|w| w.capitalize}.join
  end
end
