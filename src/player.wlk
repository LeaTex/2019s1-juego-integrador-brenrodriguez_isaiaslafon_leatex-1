import wollok.game.*

class Player {
	var property position
	var property accumulatedCarrots= []
	var image = "./bobby/bobby.png"
	var health = 100
	
	constructor() = self(game.center())
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
			and newPosition.x() < game.width()
			and newPosition.y() < game.height()
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
		health -= 50
		
		if (health <= 0) {
			game.stop()
		}
	}
	
	method removeCarrot(carrot) { self.accumulatedCarrots().remove(carrot)	}
	
	method reactTo(player) { }
}
