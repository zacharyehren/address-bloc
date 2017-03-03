require_relative '../models/address_book'

RSpec.describe AddressBook do
  describe "attributes" do
    it "responds to entries" do
      #Can this be refactored by using let?
      book = AddressBook.new
      expect(book).to respond_to(:entries)
    end

    it "initializes entries as an array" do
      book = AddressBook.new
      expect(book.entries).to be_an(Array)
    end

    it "initializes entries as empty" do
      book = AddressBook.new
      expect(book.entries.size).to eq(0)
    end
  end

    describe "#add_entry" do
      it "adds only one entry to the address book" do
        book = AddressBook.new
        book.add_entry("Zach Ehren", "216-534-5555", "zacharyehren@gmail.com")
        expect(book.entries.size).to eq(1)
      end

      it "adds the correct information to entries" do
        book = AddressBook.new
        book.add_entry("Zach Ehren", "216-534-5555", "zacharyehren@gmail.com")
        new_entry = book.entries[0]

        expect(new_entry.name).to eq("Zach Ehren")
        expect(new_entry.phone_number).to eq("216-534-5555")
        expect(new_entry.email).to eq("zacharyehren@gmail.com")
      end
    end

    describe "#remove_entry" do
      it "removes only one entry from the address book" do
        book = AddressBook.new
        book.add_entry("Jeff Goldblum", "216-555-5555", "jeffgoldblum@gmail.com")

        name = "Zach Ehren"
        phone_number = "216-534-5555"
        email = "zacharyehren@gmail.com"
        #Why is this written differently than the Jeff Goldblum entry above?
        book.add_entry(name, phone_number, email)

        expect(book.entries.size).to eq(2)
        book.remove_entry(name, phone_number, email)
        expect(book.entries.size).to eq(1)
        #Why first.name? Couldnt we use book.entries.name?
        expect(book.entries.first.name).to eq("Jeff Goldblum")
      end
    end
end
