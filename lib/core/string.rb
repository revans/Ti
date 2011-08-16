class String
  def underscore
    self.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      gsub(/\s+/, '_').
      tr("-", "_").
      downcase
  end
  
  def is_iphone?
    !!(self =~ /^iphone$/i)
  end
  
  def is_android?
    !!(self =~ /^android$/i)
  end
end