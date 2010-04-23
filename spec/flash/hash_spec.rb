require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module Sinatra::Flash
  describe FlashHash do
    before(:each) do
      @flash = {:do => 'A deer, a female deer', :re => 'A drop of golden sun'}
      @this = FlashHash.new(@flash)  # Stubbing out the session with a simple hash
      @this[:one] = "My thumb"
      @this[:two] = "My shoe"
      @this[:three] = "My knee"
    end

    it "requires a session to be passed to it" do
      lambda{FlashHash.new}.should raise_error(ArgumentError)
    end
  
    it "acts just like a Hash" do
      Hash.instance_methods.each do |method|
        @this.should respond_to(method)
      end
    end
  
    it "knows its length" do
      @this.length.should == 2
    end
    
    it "swaps its contents after one sweep" do
      @this.sweep
      @this.length.should == 3
    end
    
    it "gets rid of its contents after two sweeps" do
      @this.sweep
      @this.sweep
      @this.should be_empty
    end
    
    it "can discard the whole flash" do
      @this.discard
      @this.sweep
      @this.should be_empty
    end
    
    it "can discard just one key" do
      @this.discard(:two)
      @this.sweep
      @this.length.should == 2
    end
    
    it "can keep the whole flash" do
      @this.sweep
      @this.keep
      @this.sweep
      @this.length.should == 3
    end
    
    it "can keep just one key" do
      @this.sweep
      @this.keep(:three)
      @this.sweep
      @this.length.should == 1
    end
      
    it "doesn't know the values you set right away" do
      @this[:foo] = "bar"
      @this[:foo].should be_nil
    end
    
    it "knows the values you set next time" do
      @this[:foo] = "bar"
      @this.sweep
      @this[:foo].should == "bar"
    end
    
    it "can set values only for now" do
      @this.now[:foo] = "bar"
      @this[:foo].should == "bar"
    end
    
    it "forgets values you set only for now next time" do
      @this.now[:foo] = "bar"
      @this.sweep
      @this.now[:foo].should be_nil
    end
    
      
  end
end