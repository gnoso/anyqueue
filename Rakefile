begin
  require 'echoe'
rescue LoadError
  abort "You'll need to have `echoe' installed to use AnyQueue's Rakefile"
end
 
version = "0.1"

Echoe.new('anyqueue', version) do |p|
#  p.changelog        = "CHANGELOG.rdoc"
 
  p.author           = "Alan Johnson, Gnoso, Inc."
  p.email            = "alan@gnoso.com"
 
  p.summary = <<-DESC.strip.gsub(/\n\s+/, " ")
    AnyQueue is a queue abstraction layer. It's awesome, just because.
  DESC
 
  p.url              = "http://github.com/gnoso/anyqueue"
  p.need_zip         = true
  p.rdoc_pattern     = /^(lib|README.rdoc)/
 
  p.dependencies     =  [
    "uuidtools         >=1.0.4"
  ]
end