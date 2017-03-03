require_relative '../models/entry'

RSpec.describe Entry do
  describe "attributes" do
    let(:entry) {Entry.new("Zach Ehren", "216-534-5555", "zacharyehren@gmail.com")}

    it "responds to name" do
      expect(entry).to respond_to(:name)
    end

    it "reports its name" do
      expect(entry.name).to eq("Zach Ehren")
    end

    it "responds to phone number" do
      expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone_number" do
      expect(entry.phone_number).to eq("216-534-5555")
    end

    it "responds to email" do
      expect(entry).to respond_to(:email)
    end

    it "reports its email" do
      expect(entry.email).to eq("zacharyehren@gmail.com")
    end
  end

  describe "#to_s" do
    it "prints an entry as a string" do
      entry = Entry.new("Zach Ehren", "216-534-5555", "zacharyehren@gmail.com")
      expected_string = "Name: Zach Ehren\nPhone Number: 216-534-5555\nEmail: zacharyehren@gmail.com"
      expect(entry.to_s).to eq(expected_string)
    end
  end
end
