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
		game.height(map.boardSize().x())
		game.width(map.boardSize().y())

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
	}

	method addExtraLevelForMap(aMap) {
		var levelNumber = self.levels().size() + 1
		levels.add(new Level(levelNumber,aMap))
	}
	
	method levelOne() {
		var map = new Map(7,10)
		map.startPoint(3,1)
		map.endPoint(3,8)
	
		map.addCarrot(4,2)
		map.addCarrot(4,3)
		map.addCarrot(4,4)
		map.addCarrot(5,2)
		map.addCarrot(5,3)
		map.addCarrot(5,4)
		map.addCarrot(6,2)
		map.addCarrot(6,3)
		map.addCarrot(6,4)

		map.addElement(new Grass(0,0))
		map.addElement(new Grass(0,1))
		map.addElement(new Grass(0,5))
		map.addElement(new Grass(0,6))
		
		map.addElement(new Grass(9,0))
		map.addElement(new Grass(9,1))
		map.addElement(new Grass(9,5))
		map.addElement(new Grass(9,6))
		
		map.addElement(new Grass(3,1))
		map.addElement(new Grass(3,2))
		map.addElement(new Grass(3,4))
		map.addElement(new Grass(3,5))
		map.addElement(new Grass(4,1))
		map.addElement(new Grass(4,5))
		map.addElement(new Grass(5,1))
		map.addElement(new Grass(5,5))
		map.addElement(new Grass(6,1))
		map.addElement(new Grass(6,5))
		map.addElement(new Grass(5,1))
		map.addElement(new Grass(5,2))
		map.addElement(new Grass(5,3))
		map.addElement(new Grass(5,4))
		map.addElement(new Grass(5,5))
		
		return new Level(1,map)
	}
	method levelTwo() {
		var map = new Map(12,12)
		map.startPoint(6,1)
		map.endPoint(10,10)
	
		map.addCarrot(1,1)
		map.addCarrot(1,2)
		map.addCarrot(1,3)
		map.addCarrot(1,4)
		map.addCarrot(1,5)
		map.addCarrot(1,6)
		
		return new Level(2,map)
	}
}