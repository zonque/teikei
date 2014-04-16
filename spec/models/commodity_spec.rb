require 'spec_helper'

describe Commodity do
  before (:each) do
    @attr = {
      name: "eggs",
      priority: 10,
      commodity_group: create(:commodity_group),
    }
  end

  it "should be possible to create a commodity" do
    Commodity.create(@attr).should be_valid
  end

  it "should not be possible to create one without name" do
    @attr[:name] = nil
    Commodity.create(@attr).should_not be_valid
  end

  it "should not be possible to create one without group" do
    @attr[:commodity_group] = nil
    Commodity.create(@attr).should_not be_valid
  end

  it "should not be possible to create one with bogus priority" do
    @attr[:priority] = "thousand"
    Commodity.create(@attr).should_not be_valid
  end

  it "should return the commodities sorted by their priority" do
    Commodity.create(@attr).should be_valid

    @attr[:name] = "beer"
    @attr[:priority] = 100
    Commodity.create(@attr).should be_valid

    Commodity.all.first.name.should eq("beer")
  end

  it "should be possible to attach one to a farm" do
    f = create(:farm)
    c = Commodity.create(@attr)
    f.commodities << c
    f.commodities.first.id.should eq(c.id)
  end

end
