require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# See the spec_helper for the 'app' that we're testing.
describe Sinatra::Flash do
  before(:each) do
    Sinatra::Sessionography.session = { 
        :flash => {:marco => :polo},
        :smash => {:applecore => :baltimore}}    
  end
      
  it "provides a 'flash' helper" do
    get '/flash'
    last_response.body.should =~ /\{.*\}/
  end
  
  it "looks up the :flash variable in the session by default" do
    get '/flash'
    last_response.body.should == "{:marco=>:polo}"
  end
  
  it "is empty, not nil, if there's no session" do
    Sinatra::Sessionography.session = nil
    get '/flash'
    last_response.body.should == "{}"
  end

  it "can take a different flash key" do
    get '/flash', {:key => :smash}
    last_response.body.should == "{:applecore=>:baltimore}"
  end
  
  it "is empty, not nil, if the session doesn't have the flash key" do
    get '/flash', {:key => :trash}
    last_response.body.should == "{}"
  end
  
  it "can set the flash for the future" do
    post '/flash', {:fire => :ice}
    last_response.body.should == "{:marco=>:polo}"
  end

  it "knows the future flash" do
    post '/flash', {:fire => :ice}
    get '/flash'
    last_response.body.should == "{:fire=>:ice}"
  end
  
  it "can set a different flash key for the future" do
    post '/flash', {:key => :smash, :knockknock => :whosthere}
    get '/flash', {:key => :smash}
    last_response.body.should == "{:knockknock=>:whosthere}"
  end
  
  it "sweeps only the flash that gets used" do
    post '/flash', {:hi => :ho}
    post '/flash', {:aweem => :owep, :key => :smash}
    get '/flash', {:key => :smash}
    last_response.body.should == "{:aweem=>:owep}"
    get '/flash'
    last_response.body.should == "{:hi=>:ho}"
  end
  
  it "behaves well when nothing ever checks the flash" do
    get '/dummy'
    last_response.body.should == "This page does not invoke the flash at all."
  end
end
