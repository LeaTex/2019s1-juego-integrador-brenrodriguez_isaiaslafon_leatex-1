import wollok.game.*

class Player {
	var property position
	var property accumulatedCarrots= []
	var health = 100
	var isAlive = true
	
	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	
	method image() = "./bobby/bobby.png"
	
	method canMoveTo(nuevaPosicion) {
		
		var objects = game.getObjectsIn(nuevaPosicion)	
		return objects.isEmpty() or objects.first().canBeSteppedOn()
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
//		health -= 50
//		isAlive = health > 0
		game.say(self, "estoy reaccionando")	
	}
	
	method removeCarrot(carrot) = self.accumulatedCarrots().remove(carrot)
}
