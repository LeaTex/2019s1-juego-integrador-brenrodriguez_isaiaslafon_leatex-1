import wollok.game.*
import level.*
import gameController.*

class Player {
	var property position
	var property collectedCarrots = []
	var property alive = true
	
	constructor() = self(new Position(0,0))
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = if (alive) "./bobby/bobby.png" else "./bobby/deadBobby.png"
	
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
			 self.position(nuevaPosicion)	
			 
			 if (game.colliders(self).size() > 0) {
			 	game.colliders(self).first().reactTo(self) 
			 }
		}
	}	
	
	method receivedDamage() {
		alive = false
		game.say(self, "Ouch!!")
		
		game.onTick(2000, "deadBooby", { 
  			gameController.restartLevel()
		})
	}
	
	method collectCarrot(carrot) {
		collectedCarrots.add(carrot) 
		self.reDraw()
	}
	
	method reDraw() {
		/* Put the player again in the top layer */
		game.removeVisual(self)
		game.addVisual(self)
	}
	
	method restartAt(aPosition) {
		position = aPosition
		collectedCarrots.clear()
		alive = true
	}
}
