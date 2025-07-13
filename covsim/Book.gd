# Book.gd - Simple book with just the essentials
class_name Book extends Resource

@export var title: String = ""
@export var subject: String = ""  # Which Art this teaches
@export var level: int = 10       # Max score it can teach
@export var quality: int = 8      # XP gained per season

# How many times this character has read it (for diminishing returns)
@export var times_read: int = 0

# Can this character study this book?
func can_study(character: YoungMagus) -> bool:
	var current_score = character.get_art_score(subject)
	return current_score < level

# Study this book for one season
func study(character: YoungMagus) -> int:
	if not can_study(character):
		print("Can't study %s - character's %s (%d) already exceeds book level (%d)" % 
			[title, subject, character.get_art_score(subject), level])
		return 0
	
	# Diminishing returns: half XP each time you re-read
	var xp_gained = quality
	if times_read > 0:
		xp_gained = quality / (times_read + 1)
	
	if xp_gained < 1:
		print("Can't study %s - no more benefit from this book" % title)
		return 0
	
	times_read += 1
	character.add_xp(subject, xp_gained)
	return xp_gained

# Create a simple book
static func create(book_title: String, book_subject: String, book_level: int, book_quality: int) -> Book:
	var book = Book.new()
	book.title = book_title
	book.subject = book_subject
	book.level = book_level
	book.quality = book_quality
	return book
