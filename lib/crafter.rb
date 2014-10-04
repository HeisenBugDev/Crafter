Dir[File.dirname(__FILE__) + '/crafter/**/*.rb'].each do |file|
  load file unless file.end_with? '/crafter/version.rb'
end

module Crafter
  # Your code goes here...
end
