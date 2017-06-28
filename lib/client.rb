Dir[File.expand_path "./lib/client/*.rb"].each do |f|
  require_relative(f)
end
