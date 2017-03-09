require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0
    entries.each do |entry|
    if name < entry.name
      break
    end
    index += 1
  end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def remove_entry(name, phone_number, email)
    delete_entry = nil
    entries.each do |entry|
      if name == entry.name && phone_number == entry.phone_number && email == entry.email
        delete_entry = entry
      end
    end
    entries.delete(delete_entry)
  end

  def import_from_csv(file_name)
    #reads the file
    csv_text = File.read(file_name)
    #uses the CSV class to parse the file. the result is an object of type CSV::Table
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    #iterates over the CSV::Table object's rows
    csv.each do |row|
      #creates a hash for each row
      row_hash = row.to_hash
      #coverts each row_hash to an Entry by using the add_entry method
      #this adds the Entry to AddressBook's entries
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

end
