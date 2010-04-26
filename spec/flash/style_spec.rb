require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'sinatra/flash/style'

describe 'styled_flash method' do
  include Sinatra::Sessionography  # for the 'session' method
  include Sinatra::Flash::Storage
  include Sinatra::Flash::Style
  
  before(:each) do
    Sinatra::Sessionography.session = {:flash => {:foo=>:bar, :too=>'tar'},
                                       :smash => {:yoo=>:yar, :zoo=>'zar'}}
  end
  
  it "returns an empty string if the flash is empty" do
    Sinatra::Sessionography.session = {}
    styled_flash.should == ""
  end
  
  it "returns a div of #flash if the structure is the default" do
    styled_flash.should =~ /<div id='flash'>/
  end
  
  it "contains each key as a class" do
    styled_flash.should =~ /<div class='flash foo'>bar<\/div>/
    styled_flash.should =~ /<div class='flash too'>tar<\/div>/
  end
  
  describe "if a key is passed" do
    it "returns an empty string if that structure is empty" do
      styled_flash(:trash).should == ""
    end
    
    it "returns a div containing the key name if a key is passed" do
      styled_flash(:smash).should =~ /<div id='flash_smash'>/
    end
    
    it "returns each of the keys within that key as a class" do
      styled_flash(:smash).should =~ /<div class='flash yoo'>yar<\/div>/
      styled_flash(:smash).should =~ /<div class='flash zoo'>zar<\/div>/
    end
    
  end
end