require 'spec_helper'

describe Translation do
  before(:each) do
    @commodity = create(:commodity)
    @commodity_group = create(:commodity_group)
  end

  it "should be possible to attach a translation to a commodity" do
    t = Translation.new(title: "foo", locale: "de")
    @commodity.translations << t
    @commodity.translations.count.should eq(1)
  end

  it "should be possible to attach a translation to a commodity group" do
    t = Translation.new(title: "foo", locale: "de")
    @commodity_group.translations << t
    @commodity_group.translations.count.should eq(1)
  end

  it "shouldn't be possible to attach a translation w/o a name" do
    t = Translation.new(title: "foo")
    @commodity_group.translations << t
    @commodity_group.translations.count.should eq(0)
  end

  it "shouldn't be possible to attach a translation w/o a locale" do
    t = Translation.new(locale: "de")
    @commodity_group.translations << t
    @commodity_group.translations.count.should eq(0)
  end

  it "should be returned by a commodity" do
    t = Translation.new(title: "foo", locale: "de")
    @commodity.translations << t
    @commodity.translated_name("de").should eq("foo")
  end

  it "should be returned by a commodity group" do
    t = Translation.new(title: "foo", locale: "de")
    @commodity_group.translations << t
    @commodity_group.translated_name("de").should eq("foo")
  end

end
