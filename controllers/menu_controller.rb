require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - View Entry Number n"
    puts "6 - Exit"
    print "Enter your selection: "

    selection = gets.to_i
    puts "You picked #{selection}"

  case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      system "clear"
      entry_n_submenu
      main_menu
    when 6
      puts "Good-bye!"
      #terminates the program. 0 signals the program is exiting without an error
      exit(0)
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

  def view_all_entries
    #iterates through all the entries in the AddressBook class
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      #method that displays a submenu for each entry. method details found below
      entry_submenu(entry)
    end
    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"
    puts "New AddressBloc Entry"

    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
    print "Search by name: "
    name = gets.chomp

    match = address_book.binary_search(name)
    system "clear"

    #we check if search returned a match. this expression evaluates to false if
    #search returns nil
    #if search finds a match then we call a helper method called search_submenu
    #search_submenu displays a list of operations that can be performed on an Entry
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def search_submenu(entry)
    puts "/nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    #saves the user input to selection
    selection = gets.chomp

    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
      end
    end


  def read_csv
    #prompt the user to enter the name of a CSV file to import
    #we get the name from STDIN and call the chomp method which removes newlines
    print "Enter CSV file to import:"
    file_name = gets.chomp

    #checks to see if the file name is empty. if so, we return the user back
    #the main menu
    if file_name.empty?
      system "clear"
      puts "No CSV file to read"
      main_menu
    end

    #we import the specified file with the import from CSV method on address_book
    #we then clear the screen and print the number of entries that were added from the file
    #begin will protect the program from crashing if an exception is thrown
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    #if an exception comes up, the program is allowed to continue with the rescue block
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name"
      read_csv
    end
  end

  def entry_n_submenu
    print "Entry number to view: "
    selection = gets.chomp.to_i

    if selection < address_book.entries.count
      puts address_book.entries[selection]
      puts "Press enter to return to the main menu"
      #what does an empty gets.chomp do?
      gets.chomp
      system "clear"
    else
      puts "#{selection} is not a valid input"
      entry_n_submenu
    end
  end

  def entry_submenu(entry)

    #why doesn't n need any code to see the next entry?
    puts "n - next entry"
    puts "d - delete entry"
      delete_entry(entry)
    puts "e - edit this entry"
      edit_entry(entry)
      entry_submenu(entry)
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
      when "n"
      when "d"
      when "e"
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        entry_submenu(entry)
      end
	end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)

    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp

    #we use !attribute.empty? to set attributes on entry only if a valid attribute
    #was read from the user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry:"
    puts entry
  end

end
