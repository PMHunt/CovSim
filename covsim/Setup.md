# Ars Magica MVP Setup

## What You Get
- **YoungMagus**: Character with 15 Arts that gain XP
- **Book**: Simple books that teach Arts with diminishing returns
- **Game**: Basic game loop of study → advance time → repeat

## Quick Setup (5 minutes)

1. **Create the scripts**
   - `YoungMagus.gd`
   - `Book.gd`
   - `Game.gd`
   - `TestGame.gd`

2. **Create test scene**
   - New Scene → Add Node → rename to "TestGame"
   - Attach `TestGame.gd` script
   - Save as `TestGame.tscn`

3. **Run it**
   - Press F6 → select `TestGame.tscn`
   - Watch the console for output
   - Press Enter to manually study books

## Core Gameplay Loop

```gdscript
var game = Game.new()
game.study_book("Art of Creation")  # Character gains Creo XP
game.next_season()                  # Time advances
game.show_progress()                # See character growth
```

## What Happens

1. **Character starts** with all Arts at 0
2. **Study books** each season to gain XP
3. **XP converts to scores** using Ars Magica formula: Score = √(5×XP)
4. **Diminishing returns** - re-reading books gives less XP
5. **Time advances** through seasons and years
6. **Auto-save/load** using Godot Resources

## Example Output
```
=== Spring 1220 ===
Studying: Art of Creation
Young Magus gained 10 XP in creo (now score 2)
Success! Gained 10 XP

=== CHARACTER PROGRESS ===
Name: Young Magus (Age 25)
Arts:
  Creo: 2
  Ignem: 1
```

## Next Steps for Full Game

Once this works, add:
- Simple UI instead of console output
- More activity types (vis study, lab research)
- Covenant resources (vis stores, better library)
- Character aging and long-term progression

## Why This Works

- **No complex inheritance** - just simple Resources
- **Automatic save/load** - Godot handles serialization
- **Core math verified** - Ars Magica XP→Score conversion
- **Expandable** - easy to add features later

This gives you the essential Ars Magica feel: scholarly progression over time with meaningful choices about what to study.
