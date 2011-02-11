require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Run the specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--colour --format progress --loadby mtime --reverse']
  t.spec_files = FileList['spec/**/*_spec.rb']
end

Rake::RDocTask.new do |t|
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README')
  t.rdoc_files.include('lib/**/*.rb')
  t.options << '--inline-source'
  t.options << '--all'
  t.options << '--line-numbers'
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "vizjerai-google-checkout"
    s.summary = "An experimental library for sending payment requests to Google Checkout."
    s.email = "assarata@gmail.com"
    s.homepage = "http://github.com/vizjerai/google-checkout/"
    s.description = "An experimental library for sending payment requests to Google Checkout."
    s.authors = ["Peter Elmore", "Geoffrey Grosenbach", "Matt Lins", "Steel Fu", "Andrew Assarattanakul"]
    s.files = FileList["[A-Z]*", "{lib,spec,support,examples}/**/*"]
    s.add_dependency(%q<activesupport>, [">= 2.3.0"])
    s.add_dependency(%q<money>, [">= 2.3.0"])
    s.add_dependency(%q<nokogiri>, [">=0"])
    s.add_dependency(%q<rspec>, ["~> 1.3.0"])
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
