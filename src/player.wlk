import wollok.game.*
import level.*

class Player {
	var property position
	var property accumulatedCarrots= []
	var image = "./bobby/bobby.png"
	var property health = 100
	
	constructor() = self(new Position(0,0))
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	
	method image() = image
	
	method showDead() { image ="./bobby/deadBobby.png" }
	
	method canMoveTo(newPosition) {
		
		var objects = game.getObjectsIn(newPosition)	
		return self.isPositionInsideBoard(newPosition)
			and (objects.isEmpty() or objects.first().canBeSteppedOn())
	}
	
	method isPositionInsideBoard(newPosition) {
		return newPosition.x() >= 0
			and newPosition.y() >= 0
			and newPosition.x() < levelsList.currentLevel().map().boardSize().x()
			and newPosition.y() < levelsList.currentLevel().map().boardSize().y()
	}

	method move(nuevaPosicion) {
		
		if (self.canMoveTo(nuevaPosicion)) {
			 self.position(nuevaPosicion)	
			 
			 if (game.colliders(self).size() > 0) {
			 	game.colliders(self).first().reactTo(self) 
			 }
		}
	}	
	
	method receivedDamage() {
		health = 0
	}
	
	method removeCarrot(carrot) { self.accumulatedCarrots().remove(carrot) }
	
	method reDraw() {
		game.removeVisual(self)
		game.addVisual(self)
	}
}
