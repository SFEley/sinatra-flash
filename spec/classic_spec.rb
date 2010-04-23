# require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
# 
# # Make sure it behaves properly in a top-level 'classic' app
# 
# require 'sinatra'
# require 'sinatra/flash'
# # set test environment
# set :environment, :test
# set :run, false
# set :raise_errors, true
# set :logging, false
# 
# get "/first" do 
#   flash[:info] = 'You should see this on the second page.'
#   erb "<%= styled_flash%><h1>There should be no flash here!</h1>"
# end
# 
# describe "A Sinatra classic app" do
#   
# end