require 'spec_helper'

describe TextBlock do
  it "should be possible to create one" do
    params = { :name => "foooo", :locale => "de", :body_format => "haml" }
    t = TextBlock.create(params)
    t.should be_valid
  end

  it "should not be possible to create one without locale" do
    params = { :name => "foooo", :body_format => "haml" }
    t = TextBlock.create(params)
    t.should_not be_valid
  end

  it "should not be possible to create one without name" do
    params = { :locale => "de", :body_format => "haml"  }
    t = TextBlock.create(params)
    t.should_not be_valid
  end

  it "should not be possible to create one without body format" do
    params = { :locale => "de", :locale => "de" }
    t = TextBlock.create(params)
    t.should_not be_valid
  end

  it "should return the textblock with block_for" do
    params = { :name => "foooo", :locale => "de", :body_format => "haml", :public => true }
    t = TextBlock.create(params)
    TextBlock.block_for(params[:name], params[:locale]).should eq(t)
  end

end

