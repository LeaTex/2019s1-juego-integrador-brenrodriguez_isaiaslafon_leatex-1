import wollok.game.*
import tiles.*
import player.*

/* A Map defines the initial view of a Level. It describes the size of the playground
 * and the position of the elements */
class Map {
	var boardSize
	var startPosition
	var endPoint
	var carrots = []
	var fences = []
	var grasses = []
	var traps = []
	var keys= []
	var locks= []
	
	constructor(x,y) {
		boardSize = x->y
		startPosition = null
		endPoint = null
	}
	method boardSize(x,y) { boardSize = x->y }
	method boardSize() { return boardSize }

	method startPosition(x,y) { startPosition = new Position(x,y) }
	method startPosition() { return startPosition }

	method endPoint(x,y) { endPoint = new EndPoint(x,y) }
	method endPoint() { return endPoint }
	
	method addCarrot(x,y) { carrots.add(new Carrot(x,y)) }
	method carrots() { return carrots }
	
	method addFence(aFence) { fences.add(aFence) }
	// method fences() { return fences }

	method addGrass(aGrass) { grasses.add(aGrass) }
	// method grasses() { return grasses }

	method addTrap(aTrap) { traps.add(aTrap) }
	method traps() { return traps }
	
	method addKey(aKey) { keys.add(aKey) }
	method keys() { return keys }
	
	method addLock(aLock) { locks.add(aLock) }
	method locks() { return locks }

	method elements() { return carrots + fences + grasses + traps + locks + keys }
}

/* A Level is a dynamic representation of a Map, with contextual information */
class Level {
	const property levelNumber
	const map
	const bunny
	
	constructor(_level, _map) {
		levelNumber = _level
		map = _map
		bunny = new Player(map.startPosition())
	}

	method prepareGameAccordingToMap(aGame) {
		// game.width(map.boardSize().x())
		// game.height(map.boardSize().y())

		map.elements().forEach{ e => game.addVisual(e) }
		
		game.addVisual(map.endPoint())
		game.addVisual(bunny)
		game.addVisual(silverLock)
		game.addVisual(redLock)
		game.addVisual(goldLock)
		//game.addVisual(silverKey)
		//game.addVisual(redKey)
		//game.addVisual(goldKey)
	}
	
	method restart() {
		bunny.restartAt(map.startPosition())
		map.endPoint().endPointOff()
		map.traps().forEach{ t => t.activated(false) }
	}
	
	method map() = map
	
	method bunny() { return bunny }
	
	method player() { return self.bunny() }
	
	method initialCarrotsAmount() { return map.carrots().size() }
	
	method collectedCarrotsAmount() {
		return bunny.collectedCarrots().size()
	}
	method remainingCarrotsAmount() {
		return self.initialCarrotsAmount() - bunny.collectedCarrots().size()
	}

	method areAllCarrotsCollected() {
		return self.collectedCarrotsAmount() == self.initialCarrotsAmount()
	}
	
	method nextLevel() {return levelsList.level(levelNumber+1)}
}

/* A WKO with a hardcoded list of level to play */
object levelsList {
	var levels = []
	
	method levels() {
		if (levels.isEmpty()) self.initializeLevels()
		
		return levels
	}
	
	method level(index) {
		return if (index > self.levels().size()) self.emptyLevel()
			else { self.levels().get(index-1) }
	}
	
	method initializeLevels() {
		levels.add(self.levelOne())
		levels.add(self.levelTwo())
		levels.add(self.levelThree())
		levels.add(self.levelFour())
		levels.add(self.levelFive())
		levels.add(self.levelSix())
		levels.add(self.levelSeven())
	}

	method addExtraLevelForMap(aMap) {
		var levelNumber = self.levels().size() + 1
		levels.add(new Level(levelNumber,aMap))
	}
	
	method levelOne() {
		var mapDefinition = []
		mapDefinition.add("GG   GG")
		mapDefinition.add("   E   ")
		mapDefinition.add(" 12223 ")
		mapDefinition.add(" 4CCC6 ")
		mapDefinition.add(" 4CCC6 ")
		mapDefinition.add(" 4CCC6 ")
		mapDefinition.add(" 73 19 ")
		mapDefinition.add("   L   ")
		mapDefinition.add("   S   ")
		mapDefinition.add("GG   GG")
					 
		var map = mapBuilder.buildMapFromMatrix(mapDefinition)

		return new Level(1,map)
	}
	method levelTwo() {
		var mapDefinition = []
			
		mapDefinition.add("GGG E GGG")
		mapDefinition.add("         ")
		mapDefinition.add(" 122T2F3 ")
		mapDefinition.add(" 4CCCCC6 ")
		mapDefinition.add(" 4C C C6 ")
		mapDefinition.add(" 4CCCCC6 ")
		mapDefinition.add(" 789T789 ")
		mapDefinition.add("         ")
		mapDefinition.add("GGG   GGG")
		mapDefinition.add("GGG S GGG")
		mapDefinition.add("GGG   GGG")
		
		var map = mapBuilder.buildMapFromMatrix(mapDefinition)
		return new Level(2,map)
	}

	method levelThree() {
		var mapDefinition = []
		mapDefinition.add("GGG GGG")
		mapDefinition.add("GG E GG")
		mapDefinition.add("       ")
		mapDefinition.add("GGG GGG")
		mapDefinition.add("GCCTCCG")
		mapDefinition.add("GCCTCCG")
		mapDefinition.add("GCCTCCG")
		mapDefinition.add("GGG GGG")
		mapDefinition.add("GGG GGG")
		mapDefinition.add("GG   GG")
		mapDefinition.add("GG S GG")
		mapDefinition.add("GG   GG")
		
		var map = mapBuilder.buildMapFromMatrix(mapDefinition)
		return new Level(3,map)
	}

	method levelFour() {
		var mapDefinition = []
			
		mapDefinition.add("GG 122222223")
		mapDefinition.add("GG 4CCC4CCC6")
		mapDefinition.add("GG TCCCTCCC6")
		mapDefinition.add("GG 4CCC4CCC6")
		mapDefinition.add("GG 122222T23")
		mapDefinition.add("   4CCC4CCC6")
		mapDefinition.add(" S TCECTCCC6")
		mapDefinition.add("   4CCC4CCC6")
		mapDefinition.add("GG 788888889")
		
		var map = mapBuilder.buildMapFromMatrix(mapDefinition)
		return new Level(4,map)
	}
	
	method levelFive() {
		var mapDefinition = []
			
		mapDefinition.add("GGGGGG GGGGGG")
		mapDefinition.add("GGGGG E GGGGG")
		mapDefinition.add("T           T")
		mapDefinition.add("CGGGGGTGGGGGC")
		mapDefinition.add("CGGGGGCGGGGGC")
		mapDefinition.add("CGGGCCTCCGGGC")
		mapDefinition.add("T   CCGCC   T")
		mapDefinition.add("GGGGCCTCCGGGG")
		mapDefinition.add("GGGGGG GGGGGG")
		mapDefinition.add("GGGGGG GGGGGG")
		mapDefinition.add("GGGGG   GGGGG")
		mapDefinition.add("GGGGG S GGGGG")
		mapDefinition.add("GGGGG   GGGGG")

		var map = mapBuilder.buildMapFromMatrix(mapDefinition)
		return new Level(5,map)
	}

	method levelSix() {
		var mapDefinition = []
		
		mapDefinition.add("GGGGGGG   GGG")
		mapDefinition.add("GC  T   E GGG")
		mapDefinition.add("G GGGGG   GGG")
		mapDefinition.add("GTGGGGGGTGGGG")
		mapDefinition.add("G GGCC     CC")
		mapDefinition.add("GC  CC 789 CC")
		mapDefinition.add("GGGGCC     CC")
		mapDefinition.add("GGGGGGTGGGTGG")
		mapDefinition.add("GGGGGGCTTTCGG")
		mapDefinition.add("GGGGGGTGGGTGG")
		mapDefinition.add("   GG  CCC  G")
		mapDefinition.add(" S     CTC  G")
		mapDefinition.add("   GG  CCC  G")
		
		var map = mapBuilder.buildMapFromMatrix(mapDefinition)
		return new Level(6,map)
	}

	method levelSeven() {
		var mapDefinition = []

		mapDefinition.add("CCCGGCCCGGCCC")
		mapDefinition.add("CC TT C TT CC")
		mapDefinition.add("C  GG   GG  C")
		mapDefinition.add("GTGGGGTGGGGTG")
		mapDefinition.add("GTGGGGTGGGGTG")
		mapDefinition.add("C  GG   GG  C")
		mapDefinition.add("CC TT E TT CC")
		mapDefinition.add("C  GG   GG  C")
		mapDefinition.add("GTGGGGTGGGGTG")
		mapDefinition.add("GTGGGGTGGGGTG")
		mapDefinition.add("   GG   GG  C")
		mapDefinition.add(" S TT C TT CC")
		mapDefinition.add("   GGCCCGGCCC")
		
		var map = mapBuilder.buildMapFromMatrix(mapDefinition)
		return new Level(7,map)
	}
	method emptyLevel() {
		var mapDefinition = []
		mapDefinition.add("SE")
		var map = mapBuilder.buildMapFromMatrix(mapDefinition)
		return new Level(0,map)
	}

	method maxPlaygroundSize() {
		var maxWidth
		var maxHeight

		maxWidth = self.levels().map({ l => l.map().boardSize().x() }).max()
		maxHeight = self.levels().map({ l => l.map().boardSize().y() }).max()
		
		return maxWidth -> maxHeight  
		
	}
}

object mapBuilder {
	/*	S	start point
		E	end point
		C	carrot
		F	default fence 
		G	grass
		T	trap
		L   lock
		K   key
		Fences:
		1 2 3 = top left, horizontal and top right. 
		4   6 = vertical fence
		7 8 9 = bottom left, horizontal and bottom right
	 */
	var map

	method buildMapFromMatrix(aMatrix) {
		var width = aMatrix.first().length()
		var height = aMatrix.size()
		
		map = new Map(width, height)
		
		var rows = 0 .. (height -1)
		var columns = 0 .. (width -1)
		
		rows.forEach({ row => 
			columns.forEach({ column => 
				self.addElementAccordingTo(
					aMatrix.get(row).charAt(column), 
					height - 1 - row, 
					column
				)
			})
		})
		
		return map
	}
	
	method addElementAccordingTo(char, y, x) {
		if (char == "S") { map.startPosition(x,y) }
		if (char == "E") { map.endPoint(x,y) }
		if (char == "C") { map.addCarrot(x,y) }
		if (char == "G") { map.addGrass(new Grass(x,y)) }
		if (char == "T") { map.addTrap(new Trap(x,y)) }
		if (char == "F") { map.addFence(new Fence(x,y)) }
		if (char == "L") { map.addLock(goldLock) }
		//if (char == "K") { map.addKey(redKey) }
		
		
		if (char == "1") { map.addFence(new Fence(x,y, fenceType.topLeft())) }
		if (char == "3") { map.addFence(new Fence(x,y,fenceType.topRight())) }
		if (char == "7") { map.addFence(new Fence(x,y,fenceType.bottomLeft())) }
		if (char == "9") { map.addFence(new Fence(x,y,fenceType.bottomRight())) }
		if (char == "2" or char == "8") { map.addFence(new Fence(x,y,fenceType.horizontal())) }
		if (char == "4" or char == "6") { map.addFence(new Fence(x,y,fenceType.vertical())) }
		
	}
}