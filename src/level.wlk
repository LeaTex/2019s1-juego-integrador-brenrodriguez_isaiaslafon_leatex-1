import wollok.game.*
import tiles.*

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
