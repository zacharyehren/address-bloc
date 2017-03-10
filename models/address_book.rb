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

  def binary_search(name)
    #saves the index of the leftmost item in the array as lower and the index
    #of the rightmost entry as upper
    lower = 0
    upper = entries.length - 1

    #while the lower index is less than or equal to our upper index...
    while lower <= upper
    #we find the middle index by taking the sum of the lower and upper and
    #dividing it by two. Ruby truncates any decimal numbers so if upper is 5 and
    #lower is zero, then mid will get set to 2
      mid = (lower + upper) / 2
    #finally we retrieve the name of the entry at the middle index and store it
    #as mid_name
      mid_name = entries[mid].name
    #we compare the name we are searching for to the name of the middle index
      if name == mid_name
    #if the condition above is true, we return the entry
        return entries[mid]
    #if name is before mid_name, we set upper to mid - 1 because the name
    #must be in the lower half of the array
      elsif name < mid_name
        upper = mid - 1
    #if name is after mid_name, then we set lower to mid + 1 because the name
    #must be in the upper half of the array
      elsif name > mid_name
        lower = mid + 1
      end
    end
      return nil

  end

end
