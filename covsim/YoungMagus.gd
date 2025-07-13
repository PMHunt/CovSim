# YoungMagus.gd - Character class with clear XP vs Score separation
class_name YoungMagus
extends Resource

@export var name: String = "New Magus"
@export var age: int = 25

# === ARTS EXPERIENCE POINTS (Raw XP accumulated) ===
# These are the raw experience points gained from study
@export var creo_xp: int = 0        # Creation XP
@export var intellego_xp: int = 0   # Perception XP
@export var muto_xp: int = 0        # Transformation XP
@export var perdo_xp: int = 0       # Destruction XP
@export var rego_xp: int = 0        # Control XP

@export var animal_xp: int = 0      # Animal Form XP
@export var aquam_xp: int = 0       # Water Form XP
@export var auram_xp: int = 0       # Air Form XP
@export var corpus_xp: int = 0      # Body Form XP
@export var herbam_xp: int = 0      # Plant Form XP
@export var ignem_xp: int = 0       # Fire Form XP
@export var imaginem_xp: int = 0    # Image Form XP
@export var mentem_xp: int = 0      # Mind Form XP
@export var terram_xp: int = 0      # Earth Form XP
@export var vim_xp: int = 0         # Magic Form XP

# Dictionary of all arts XP for easy iteration
var arts_xp: Dictionary = {}

# Use lookup tables, not formulas
const ART_XP_TABLE = {
	0: 0, 1: 1, 2: 3, 3: 6, 4: 10, 5: 15,
	6: 21, 7: 28, 8: 36, 9: 45, 10: 55,
	11: 66, 12: 78, 13: 91, 14: 105, 15: 120,
	16: 136, 17: 153, 18: 171, 19: 190, 20: 210
}

func _init(magus_name: String = "New Magus", starting_age: int = 25):
	name = magus_name
	age = starting_age
	_update_arts_xp_dict()

# === XP MANAGEMENT ===
func add_xp(art_name: String, xp_gained: int):
	"""Add experience points to a specific art"""
	match art_name.to_lower():
		"creo": creo_xp += xp_gained
		"intellego": intellego_xp += xp_gained
		"muto": muto_xp += xp_gained
		"perdo": perdo_xp += xp_gained
		"rego": rego_xp += xp_gained
		"animal": animal_xp += xp_gained
		"aquam": aquam_xp += xp_gained
		"auram": auram_xp += xp_gained
		"corpus": corpus_xp += xp_gained
		"herbam": herbam_xp += xp_gained
		"ignem": ignem_xp += xp_gained
		"imaginem": imaginem_xp += xp_gained
		"mentem": mentem_xp += xp_gained
		"terram": terram_xp += xp_gained
		"vim": vim_xp += xp_gained
	_update_arts_xp_dict()

func get_art_xp(art_name: String) -> int:
	"""Get raw experience points for a specific art"""
	match art_name.to_lower():
		"creo": return creo_xp
		"intellego": return intellego_xp
		"muto": return muto_xp
		"perdo": return perdo_xp
		"rego": return rego_xp
		"animal": return animal_xp
		"aquam": return aquam_xp
		"auram": return auram_xp
		"corpus": return corpus_xp
		"herbam": return herbam_xp
		"ignem": return ignem_xp
		"imaginem": return imaginem_xp
		"mentem": return mentem_xp
		"terram": return terram_xp
		"vim": return vim_xp
		_: return 0

# === SCORE CALCULATION ===
func get_art_score(art_name: String) -> int:
	"""Convert XP to actual ability score using triangular progression"""
	var xp = get_art_xp(art_name)
	return xp_to_score(xp)

func xp_to_score(xp: int) -> int:
	"""Fast lookup from XP to Score using lookup table"""
	if xp <= 0:
		return 0
	
	for score in range(20, -1, -1):
		if xp >= ART_XP_TABLE[score]:
			return score
	return 0

func score_to_xp(score: int) -> int:
	"""Get XP needed for a specific score level using lookup table"""
	if score <= 0 or score > 20:
		return 0
	return ART_XP_TABLE[score]

# === CASTING TOTALS ===
func get_casting_total(technique: String, form: String) -> int:
	"""Get total casting ability (technique score + form score)"""
	return get_art_score(technique) + get_art_score(form)

# === DISPLAY METHODS ===
func get_character_summary() -> String:
	var summary = "=== %s (Age %d) ===\n" % [name, age]
	
	summary += "\nTECHNIQUES (Score [XP]):\n"
	summary += "  Creo (Creation): %d [%d XP]\n" % [get_art_score("creo"), creo_xp]
	summary += "  Intellego (Perception): %d [%d XP]\n" % [get_art_score("intellego"), intellego_xp]
	summary += "  Muto (Transformation): %d [%d XP]\n" % [get_art_score("muto"), muto_xp]
	summary += "  Perdo (Destruction): %d [%d XP]\n" % [get_art_score("perdo"), perdo_xp]
	summary += "  Rego (Control): %d [%d XP]\n" % [get_art_score("rego"), rego_xp]
	
	summary += "\nFORMS (Score [XP]):\n"
	summary += "  Animal: %d [%d XP]\n" % [get_art_score("animal"), animal_xp]
	summary += "  Aquam (Water): %d [%d XP]\n" % [get_art_score("aquam"), aquam_xp]
	summary += "  Auram (Air): %d [%d XP]\n" % [get_art_score("auram"), auram_xp]
	summary += "  Corpus (Body): %d [%d XP]\n" % [get_art_score("corpus"), corpus_xp]
	summary += "  Herbam (Plant): %d [%d XP]\n" % [get_art_score("herbam"), herbam_xp]
	summary += "  Ignem (Fire): %d [%d XP]\n" % [get_art_score("ignem"), ignem_xp]
	summary += "  Imaginem (Image): %d [%d XP]\n" % [get_art_score("imaginem"), imaginem_xp]
	summary += "  Mentem (Mind): %d [%d XP]\n" % [get_art_score("mentem"), mentem_xp]
	summary += "  Terram (Earth): %d [%d XP]\n" % [get_art_score("terram"), terram_xp]
	summary += "  Vim (Magic): %d [%d XP]\n" % [get_art_score("vim"), vim_xp]
	
	return summary

func get_arts_with_scores() -> Dictionary:
	"""Get all arts with both XP and calculated scores"""
	return {
		"techniques": {
			"creo": {"xp": creo_xp, "score": get_art_score("creo")},
			"intellego": {"xp": intellego_xp, "score": get_art_score("intellego")},
			"muto": {"xp": muto_xp, "score": get_art_score("muto")},
			"perdo": {"xp": perdo_xp, "score": get_art_score("perdo")},
			"rego": {"xp": rego_xp, "score": get_art_score("rego")}
		},
		"forms": {
			"animal": {"xp": animal_xp, "score": get_art_score("animal")},
			"aquam": {"xp": aquam_xp, "score": get_art_score("aquam")},
			"auram": {"xp": auram_xp, "score": get_art_score("auram")},
			"corpus": {"xp": corpus_xp, "score": get_art_score("corpus")},
			"herbam": {"xp": herbam_xp, "score": get_art_score("herbam")},
			"ignem": {"xp": ignem_xp, "score": get_art_score("ignem")},
			"imaginem": {"xp": imaginem_xp, "score": get_art_score("imaginem")},
			"mentem": {"xp": mentem_xp, "score": get_art_score("mentem")},
			"terram": {"xp": terram_xp, "score": get_art_score("terram")},
			"vim": {"xp": vim_xp, "score": get_art_score("vim")}
		}
	}

# === INTERNAL METHODS ===
func _update_arts_xp_dict():
	"""Update the arts_xp dictionary for backward compatibility"""
	arts_xp = {
		"creo": creo_xp,
		"intellego": intellego_xp,
		"muto": muto_xp,
		"perdo": perdo_xp,
		"rego": rego_xp,
		"animal": animal_xp,
		"aquam": aquam_xp,
		"auram": auram_xp,
		"corpus": corpus_xp,
		"herbam": herbam_xp,
		"ignem": ignem_xp,
		"imaginem": imaginem_xp,
		"mentem": mentem_xp,
		"terram": terram_xp,
		"vim": vim_xp
	}
