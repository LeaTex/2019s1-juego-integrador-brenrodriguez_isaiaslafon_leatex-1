# Project Name: "Bobby Carrot"
Names not used: "El conejo angurriento", "Bobby Carrot Reloaded", "mangia carota", "robo salvaje", "farm survival"

# Project type: 
"Bobby Carrot" Puzzler Game Type

Objects and classes to implement descriptions:

#Player: 
-1 player only at the moment (Object or class depending if feature 2 players is or not available).
-Can move 4 directions (up, down, left and right), there are walkable and non walkable positions.
-a positions can get the player kill.
-a positions get the player carrot counter down only once.
-a positions make a switch on/off alternatively.
-a positions change direction of the tile after player pass it through.
-a position make the level end (only when carrot counter is 0)

#Limits classes:
-Obstacle (Fences, Grass, etc.). 
	Player can not walk over it (every one have his constant image but same behavior)
	Obstacles have a set of different images but only use one at instantiation.
	
-Door/Gate. 
	Can be open or close depending on other objects interaction with player), has a boolean variable if it open or close.
	Can be related to Switches.
	
-Switch. 
	Change door position and belt direction.
	
-Spike Trap.
	Can be walkable by player only one, change game to game over condition at a second pass. 
	Have a boolean variable if something walk by once.
	
-Belt transporter.
	Move Bobby in direction to the next tile at the end of the belt.
	Change direction checking switch position.
	Can have 1 or two states at the beginning and change direction.
	Is linked to switches. 

-Rotational runway.
	Exist in L or Straight shape.
	Rotate every time something pass through.
	
-Walkable Tile superclass. 
	Can be walkable and have a constant image 
	or Can have a grabbable item and change image and properties after player collision (hole after carrot removed).	

#Special Objects:
-spawn point
	unique image, variation of a Walkable Tile and set player start position.
-Game Conditions
	have a total carrot condition
	level end condition
	game over condition
-Exit point
	Change image using carrot condition
	
(-clock time counter
	Is a object that count time.)
-reset level
	reload the level 
	
	
#Other features:
-level selection map
-level editor
-walking animation graphic movement
-New game mechanics "rewind time function"
-Temporal save
-time counter
-add edited levels
-level selection menu

Pending Stuff:
-Walk on Spikes Up make bobby die
-Spikes get up only when player leave position 
(tip: temporal list of object player walk previous time)

-Rotational runway in L or I shape that rotates clockwise when layer leave position and limit walk in some directions.
(tip: same as spikes, and also add availeable moves on player).
-Button that make runways rotate again.
-Pass level feature.
(tip: must be on "any key press")
-add sounds.

TIPS:
Only stuff impossible to tes: KEYS, COLLIDERS, ONTICK
CANT RESIZE SCREEN AFTER FIRST RUN OF THE GAME
OK TO CHANGE Class obstacle intead of grass, fences an others.
-To avoid REDRAW the player we can add every carrot with a hole ground tile before, once is a carrot removed the hole graound is already there.




