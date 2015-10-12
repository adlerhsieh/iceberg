module Map
  # Get = {} of String => Hash(Symbol,Symbol)
  # Post = {} of String => Hash(Symbol,Symbol)
  Get = {} of String => Proc(Iceberg::Params, String)
  Post = {} of String => Proc(Iceberg::Params, String)
end
