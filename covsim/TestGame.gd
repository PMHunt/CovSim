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
	print("\n=== STARTING GAMEPLAY TEST ===")
	
	# Test studying books
	print("\n--- Testing book study ---")
	
	# Try to study available books
	var book_titles = game.get_book_titles()
	if book_titles.size() > 0:
		# Get first book title (remove the ✓ or ✗ indicator)
		var first_book = book_titles[0].substr(0, book_titles[0].length() - 2)
		print("\nTrying to study: " + first_book)
		game.study_book(first_book)
	
	# Show progress after studying
	game.show_progress()
	
	# Advance season
	game.next_season()
	
	# Continue studying for a few more seasons
	print("\n--- Continuing study for multiple seasons ---")
	for i in range(5):
		print("\n--- Season %d ---" % (i + 2))
		
		# Pick a random available book
		var available_books = game.get_book_titles()
		if available_books.size() > 0:
			var random_index = randi() % available_books.size()
			var book_title = available_books[random_index].substr(0, available_books[random_index].length() - 2)  # Remove ✓/✗ indicator
			print("Studying: " + book_title)
			game.study_book(book_title)
		else:
			print("No books available!")
		
		# Advance to next season
		game.next_season()
	
	# Show final state
	print("\n--- Final State ---")
	game.show_progress()
	
	# Show character info
	print("\n--- Character Summary ---")
	print(game.character.get_character_summary())
	
	# Test save/load
	print("\n--- Testing Save/Load ---")
	game.save_game()
	game.load_game()
	
	print("\n=== GAMEPLAY TEST COMPLETE ===")
