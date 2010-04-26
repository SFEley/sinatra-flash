require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sinatra-flash"
    gem.summary = %Q{Proper flash messages in Sinatra}
    gem.description = %Q{A Sinatra extension for setting and showing Rails-like flash messages. This extension improves on the Rack::Flash gem by being simpler to use, providing a full range of hash operations (including iterating through various flash keys, testing the size of the hash, etc.), and offering a 'styled_flash' view helper to render the entire flash hash with sensible CSS classes. The downside is reduced flexibility -- these methods will *only* work in Sinatra.}
    gem.email = "sfeley@gmail.com"
    gem.homepage = "http://github.com/SFEley/sinatra-flash"
    gem.authors = ["Stephen Eley"]
    gem.add_dependency "sinatra", ">= 1.0.0"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "yard", ">= 0"
    gem.add_development_dependency "sinatra-sessionography"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

