require_relative 'controllers/menu_controller'

#creating a new MenuController from the MenuController class
menu = MenuController.new

#clears the command line
system = "clear"
puts "Welcome to AddressBloc!"

#fires the main_menu method from the MenuController class
menu.main_menu
