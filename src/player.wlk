import wollok.game.*
import level.*
import gameAssets.*
import gameController.*

class Player {
	var property position
	var property alive = true
	var property direction  = 0
	var collected = 0
	
	constructor() = self(new Position(0,0))
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position 
	}

	method image() = if (alive) assets.get("bobby") else assets.get("deadBobby")
	
	method canMoveTo(newPosition) {
		
		var objects = game.getObjectsIn(newPosition)	
		return self.isPositionInsideBoard(newPosition)
			and (objects.isEmpty() or objects.first().canBeSteppedOn())
	}
	
	method isPositionInsideBoard(newPosition) {
		return newPosition.x() >= 0
			and newPosition.y() >= 0
			and newPosition.x() < gameController.playingLevel().map().boardSize().x()
			and newPosition.y() < gameController.playingLevel().map().boardSize().y()
	}

	method move(nuevaPosicion) {
		
		if (alive and self.canMoveTo(nuevaPosicion)) {
			 const previousPosition = position
			 direction =  new Position(nuevaPosicion.x() - self.position().x(), nuevaPosicion.y() - self.position().y())
			 self.position(nuevaPosicion)	
			
			 //console.println(direction)
			gameController.updateTraps(previousPosition)
			
			if (game.colliders(self).size() > 0) {
				game.colliders(self).forEach({ anObject => if (anObject != self) anObject.reactTo(self) }) 
			}
		}
	}	
	
	method collect() { collected += 1}
	method resetCollected() { collected = 0}
	method collected() = collected
	
	method die() {
		alive = false
		game.say(self, "Ouch!! traps are deadly once activated")
		
		game.onTick(2000, "deadBooby", { 
  			gameController.restartLevel()
		})
	}
	
	method resetAt(aPosition) {
		position = aPosition
		alive = true
		self.resetCollected()
	}
}
