# TestGame.gd - Simple test of the game system
# Attach this to a Node in your scene to test
extends Node

var game: Game

func _ready():
	# Create new game
	game = Game.new()
	
	# Show starting state
	game.show_progress()
	print("\nAvailable books:")
	for title in game.get_book_titles():
		print("  " + title)
	
	# Simulate a few seasons of study
	test_gameplay()

func test_gameplay():
	print("\n" + "=".repeat(40))
	print("TESTING GAMEPLAY LOOP")
	print("=".repeat(40))
	
	# Season 1: Study Creo
	game.study_book("Art of Creation")
	game.next_season()
	
	# Season 2: Study Ignem  
	game.study_book("Dancing Flame")
	game.next_season()
	
	# Season 3: Study Creo again (diminishing returns)
	game.study_book("Art of Creation") 
	game.next_season()
	
	# Season 4: Study Vim
	game.study_book("Raw Magic")
	game.next_season()
	
	# Show final progress
	print("\n" + "=".repeat(40))
	print("FINAL RESULTS")
	print("=".repeat(40))
	game.show_progress()
	
	# Test save/load
	game.save_game()
	game.load_game()

# For testing in the editor
func _input(event):
	if event.is_action_pressed("ui_accept"):  # Enter key
		print("\n--- Manual Study Test ---")
		print("Available books:")
		var titles = game.get_book_titles()
		for i in range(titles.size()):
			print("%d. %s" % [i+1, titles[i]])
		
		# Study first available book
		for book in game.books:
			if book.can_study(game.character):
				game.study_book(book.title)
				game.next_season()
				break
