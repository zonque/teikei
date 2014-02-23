require 'spec_helper'

describe Place do

  before do
    @place = build(:place)
    @user = create(:user)
    @another_user = create(:user, name: "Another user")
    @admin = create(:admin)
  end

  it "should be valid" do
    expect(@place).to be_valid
  end

  it "requires a name" do
    @place.name = ""
    expect(@place).not_to be_valid
  end

  it "rejects a name longer than 100 characters" do
    long_name = "a" * 101
    @place.name = long_name
    expect(@place).not_to be_valid
  end

  it "rejects an empty city string" do
    @place.city = ""
    expect(@place).not_to be_valid
  end

  it "rejects a city longer than 100 characters" do
    long_city = "a" * 101
    @place.city = long_city
    expect(@place).not_to be_valid
  end

  it "rejects an empty address" do
    @place.address = ""
    expect(@place).not_to be_valid
  end

  it "rejects an address longer than 100 characters" do
    long_address = "a" * 101
    @place.address = long_address
    expect(@place).not_to be_valid
  end

  it "rejects the boolean flag is_established which is nil" do
    @place.is_established = nil
    expect(@place).not_to be_valid
  end

  it "accepts the boolean flag is_established when true" do
    @place.is_established = true
    expect(@place).to be_valid
  end

  it "accepts the boolean flag is_established when false" do
    @place.is_established = false
    expect(@place).to be_valid
  end

  it "rejects invalid contact urls" do
    @place.contact_url = "wwww.foo.bar.baz//|%"
    expect(@place).not_to be_valid

    @place.contact_url = "file://foo.txt"
    expect(@place).not_to be_valid
  end

  it "adds a protocol to the url if it is missing" do
    @place.contact_url = "www.example.com"
    expect(@place).to be_valid
    expect(@place.contact_url).to eq("http://www.example.com")

    @place.contact_url = "example.com"
    expect(@place).to be_valid
    expect(@place.contact_url).to eq("http://example.com")

    @place.contact_url = "subdomain.foobar.com"
    expect(@place).to be_valid
    expect(@place.contact_url).to eq("http://subdomain.foobar.com")
  end

  it "accepts valid contact urls" do

    @place.contact_url = "http://example.com"
    expect(@place).to be_valid

    @place.contact_url = "https://highsecurityplace.com"
    expect(@place).to be_valid
  end

  it "prefixes the url with a protocol if required" do
  end

  it "rejects invalid contact phones" do
    @place.contact_phone = "foobar 1234"
    expect(@place).not_to be_valid

    @place.contact_phone = "++ 123 12 321 3123"
    expect(@place).not_to be_valid

    @place.contact_phone = "123-123-123 foo"
    expect(@place).not_to be_valid
  end

  it "accepts valid contact phones" do
    @place.contact_phone = "+49 12 3123 123 12 3123"
    expect(@place).to be_valid

    @place.contact_phone = "030 1231-123-123-123"
    expect(@place).to be_valid

    @place.contact_phone = "121231231231231"
    expect(@place).to be_valid

    @place.contact_phone = "030/123123 123 123"
    expect(@place).to be_valid
  end

  it "accepts a blank phone" do
    @place.contact_phone = ''
    expect(@place).to be_valid
  end

  it "inserts a relation entry" do
    place = build(:place, name: "A place")
    @place.places << place
    expect(@place.places).to include(place)
  end

  it "removes a relation entry" do
    place = build(:place, name: "A place")
    @place.places << place
    @place.places.delete(place)
    expect(@place.places).to eql([])
  end

  it "replaces an existing relation entry" do
    partner_place = create(:place, name: "Partnerplace")
    @place.places = [partner_place]
    @place.places =[]
    expect(@place.places).to eql([])
  end

  it "inserts an ownership" do
    user = create(:user)
    @place.users << user
    expect(@place.users).to include(user)
  end

  it "removes an ownership" do
    user = create(:user)
    @place.users << user
    @place.users.delete(user)
    @place.save!
    expect(@place.users).not_to include(user)
  end

  it "replaces an existing ownership" do
    user = create(:user)
    @place.users = [user]
    @place.users =[]
    expect(@place.users).to eql([])
  end

  it "returns a joined string built from address and city as the location when both fields are given" do
    place = build(:place, address: "Fehrbelliner Str. 45a", city: "Neuruppin")
    expect(place.location).to eq("Fehrbelliner Str. 45a Neuruppin")
  end

  it "returns only the city as the location when the address is not given" do
    place = build(:place, address: nil, city: "Neuruppin")
    expect(place.location).to eq("Neuruppin")
  end

  it "returns only the address as the location when the city is not given" do
    place = build(:place, address: "Fehrbelliner Str. 45a", city: nil)
    expect(place.location).to eq("Fehrbelliner Str. 45a")
  end

  it "returns nil for the location field when address and city are not given" do
    place = build(:place, address: nil, city: nil)
    expect(place.location).to eq(nil)
  end

  context "for a guest user" do
    it "rejects authorization" do
      @place.users = [@user]
      expect(@place.authorized?(nil)).to be_false
    end
  end

  context "for a user without ownership" do
    it "rejects authorization" do
      @place.users = [@another_user]
      expect(@place.authorized?(@user)).to be_false
    end
  end

  context "for the owner" do
    it "grants authorization" do
      @place.users = [@user]
      expect(@place.authorized?(@user)).to be_true
    end
  end

  context "for an admin user" do
    it "grants authorization" do
      expect(@place.authorized?(@admin)).to be_true
    end
  end

end
