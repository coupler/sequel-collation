require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'test/unit'
require 'sequel'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
Sequel.extension :collation

class Test::Unit::TestCase
  def database_for(adapter, &block)
    @@config ||= YAML.load_file(File.join(File.dirname(__FILE__), "config.yml"))
    config = @@config[adapter]
    if config
      if block
        Sequel.connect(config, &block)
      else
        Sequel.connect(config)
      end
    else
      omit("Couldn't find configuration for adapter '#{adapter}'")
    end
  end
end
