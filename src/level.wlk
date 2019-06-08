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
}

/* A WKO with a hardcoded list of level to play */
object levelsList {
	method levelOne() {
		var map = new Map(15,15)
		map.startPoint(3,3)
		map.endPoint(5,5)
	
		map.addCarrot(5,5)
		map.addCarrot(2,7)
		map.addCarrot(8,7)
		map.addCarrot(5,4)
		map.addCarrot(1,9)
		map.addElement(new Wall(5,7))
		map.addElement(new Trap(3,5))
		
		return new Level(1,map)
	}
}