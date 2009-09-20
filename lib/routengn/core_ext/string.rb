class String
  def pluralize
    self + 's' # for now
  end

  def constantize
   unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self
     raise NameError, "#{self} is not a valid constant name!"
   end

   Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end
end
