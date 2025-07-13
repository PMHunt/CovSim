# Game.gd - Simple game manager
class_name Game extends Resource

var character: YoungMagus
var books: Array[Book] = []
var current_season: String = "Spring"
var current_year: int = 1220

func _init():
	start_new_game()

func start_new_game():
	# Create character
	character = YoungMagus.new()
	character.name = "Young Magus"
	
	# Create some starter books
	books = [
		Book.create("Art of Creation", "creo", 15, 10),
		Book.create("Eye of Understanding", "intellego", 12, 8),
		Book.create("Foundations of Change", "muto", 10, 9),
		Book.create("Dancing Flame", "ignem", 12, 11),
		Book.create("Stone and Metal", "terram", 14, 7),
		Book.create("Raw Magic", "vim", 8, 12)
	]
	
	print("=== NEW GAME STARTED ===")
	print("Character: %s (Age %d)" % [character.name, character.age])
	print("Season: %s %d" % [current_season, current_year])
	print("Available books: %d" % books.size())

# Study a book for the current season
func study_book(book_title: String) -> bool:
	var book = find_book(book_title)
	if not book:
		print("Book '%s' not found!" % book_title)
		return false
	
	print("\n=== %s %d ===" % [current_season, current_year])
	print("Studying: %s" % book.title)
	
	var xp = book.study(character)
	if xp > 0:
		print("Success! Gained %d XP" % xp)
		return true
	else:
		print("Study failed!")
		return false

# Find a book by title
func find_book(title: String) -> Book:
	for book in books:
		if book.title == title:
			return book
	return null

# Advance to next season
func next_season():
	match current_season:
		"Spring": current_season = "Summer"
		"Summer": current_season = "Autumn" 
		"Autumn": current_season = "Winter"
		"Winter": 
			current_season = "Spring"
			current_year += 1
			character.age += 1

# Get list of book titles
func get_book_titles() -> Array[String]:
	var titles: Array[String] = []
	for book in books:
		var can_study_text = " ✓" if book.can_study(character) else " ✗"
		titles.append(book.title + can_study_text)
	return titles

# Show character progress
func show_progress():
	print("\n=== CHARACTER PROGRESS ===")
	print("Name: %s (Age %d)" % [character.name, character.age])
	print("Arts:")
	for art in character.arts_xp:
		var score = character.get_art_score(art)
		if score > 0:
			print("  %s: %d" % [art.capitalize(), score])

# Save game
func save_game():
	ResourceSaver.save(character, "user://character.tres")
	print("Game saved!")

# Load game  
func load_game():
	if ResourceLoader.exists("user://character.tres"):
		character = ResourceLoader.load("user://character.tres")
		print("Game loaded!")
	else:
		print("No save file found!")
