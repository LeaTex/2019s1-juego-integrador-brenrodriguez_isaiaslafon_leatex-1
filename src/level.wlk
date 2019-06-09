import wollok.game.*
import tiles.*
import player.*

/* A Map defines the initial view of a Level. It describes the size of the playground
 * and the position of the elements */
class Map {
	var boardSize
	var startPoint
	var endPoint
	var carrots = []
	var elements = []
	
	constructor(x,y) {
		boardSize = x->y
		startPoint = null
		endPoint = null
	}
	method boardSize(x,y) { boardSize = x->y }
	method boardSize() { return boardSize }

	method startPoint(x,y) { startPoint = new Position(x,y) }
	method startPoint() { return startPoint }

	method endPoint(x,y) { endPoint = new EndPoint(x,y) }
	method endPoint() { return endPoint }
	
	method addCarrot(x,y) { carrots.add(new Carrot(x,y)) }
	method carrots() { return carrots }
	
	method addElement(anElement) { elements.add(anElement) }
	method elements() { return elements }
}

/* A Level is a dynamic representation of a Map, with contextual information */
class Level {
	const levelNumber
	const map
	const bunny
	var carrotsOnBoard = []
	
	constructor(_level, _map) {
		levelNumber = _level
		map = _map
		bunny = new Player(map.startPoint())
		carrotsOnBoard.addAll(map.carrots())
	}

	method prepareGameAccordingToMap(aGame) {
		game.width(map.boardSize().x())
		game.height(map.boardSize().y())

		map.carrots().forEach{ z => game.addVisual(z) }
		map.elements().forEach{ e => game.addVisual(e) }
		
		game.addVisual(map.endPoint())
		game.addVisual(bunny)
	}
	
	method bunny() { return bunny }
	method player() { return self.bunny() }
	
	method initialCarrotsAmount() { return map.carrots().size() }
	
	method collectedCarrotsAmount() {
		return self.initialCarrotsAmount() - carrotsOnBoard.size()
	}
	
	method allCollected() {
		return self.collectedCarrotsAmount() == self.initialCarrotsAmount()
	}
}

/* A WKO with a hardcoded list of level to play */
object levelsList {
	var levels = []
	
	method levels() {
		if (levels.isEmpty()) self.initializeLevels()
		
		return levels
	}
	method level(index) { return self.levels().get(index-1) }
	
	method initializeLevels() {
		levels.add(self.levelOne())
		levels.add(self.levelTwo())
		levels.add(self.levelThree())
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
		mapDefinition.add("       ")
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
}

object mapBuilder {
	/*	S	start point
		E	end point
		C	carrot
		F	default fence 
		G	grass
		T	trap
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
		if (char == "S") { map.startPoint(x,y) }
		if (char == "E") { map.endPoint(x,y) }
		if (char == "C") { map.addCarrot(x,y) }
		if (char == "F") { map.addElement(new Fence(x,y,fenceType.horizontal())) }
		if (char == "G") { map.addElement(new Grass(x,y)) }
		if (char == "T") { map.addElement(new Trap(x,y)) }
		
		if (char == "1") { map.addElement(new Fence(x,y, fenceType.topLeft())) }
		if (char == "3") {map.addElement(new Fence(x,y,fenceType.topRight())) }
		if (char == "7") { map.addElement(new Fence(x,y,fenceType.bottomLeft())) }
		if (char == "9") { map.addElement(new Fence(x,y,fenceType.bottomRight())) }
		if (char == "2" or char == "8") { map.addElement(new Fence(x,y,fenceType.horizontal())) }
		if (char == "4" or char == "6") { map.addElement(new Fence(x,y,fenceType.vertical())) }
		
	}
}