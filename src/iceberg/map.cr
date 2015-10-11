module Map
  # Get = {} of String => Hash(Symbol,Symbol)
  # Post = {} of String => Hash(Symbol,Symbol)
  Get = {} of String => Proc(String)
  Post = {} of String => Proc(String)
end
