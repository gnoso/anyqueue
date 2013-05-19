begin
  require "bundler/gem_tasks"
  require "echoe"
rescue LoadError
  abort "You need to have the gem 'echoe' installed to use AnyQueue's Rakefile."
end

Echoe.new('anyqueue', Anyqueue::VERSION) do |spec|
  spec.author = "Alan Johnson, Taylor Shuler"
  spec.email = "alan@gnoso.com, taylorshuler@aol.com"
  spec.dependencies = ["uuidtools >= 1.0.4"]
  spec.url = "https://github.com/gnoso/anyqueue"
  spec.need_zip = true
end