Dir.glob(File.expand_path('~/.local/irb*.rb', __FILE__)).each do |file|
  require file
end
