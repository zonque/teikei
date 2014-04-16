require 'spec_helper'

describe CommodityGroup do
  before (:each) do
    @attr = {
      name: "beverages",
      priority: 10,
    }
  end

  it "should be possible to create a commodity group" do
    CommodityGroup.create(@attr).should be_valid
  end

  it "should not be possible to create one without name" do
    @attr[:name] = nil
    CommodityGroup.create(@attr).should_not be_valid
  end

  it "should not be possible to create one with bogus priority" do
    @attr[:priority] = "thousand"
    CommodityGroup.create(@attr).should_not be_valid
  end

  it "should return the commodity groups sorted by their priority" do
    CommodityGroup.create(@attr).should be_valid

    @attr[:name] = "meat"
    @attr[:priority] = 100
    CommodityGroup.create(@attr).should be_valid

    CommodityGroup.all.first.name.should eq("meat")
  end
end
