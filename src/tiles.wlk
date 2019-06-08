import wollok.game.*

class Wall {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = "fence01.png"

	method canBeSteppedOn() = false

}



class Grass {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = "spot.png"

	method canBeSteppedOn() = false

}


class Carrot {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = "spot.png"

	method  canBeSteppedOn () = true
	
	method reactTo(player, level){
		level.initialCarrotsAmount().remove(self)
		game.removeVisual(self)
		game.addVisualIn(hole, self.position())
	}
}


class EndPoint {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }
	
	method reactTo(player, level){
		//go to next level
	}
}

class Trap { 
	var property activated = false 
	var property position 
	 
	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }
	 
	method image() = if (activated) "corn_adult.png" else "corn_baby.png" 
	 
	method  canBeSteppedOn () = true 
	 
	 
	method reactTo(player) { 
		 
		if (self.activated()) { 
			game.say(self, "activada") 
			player.receivedDamage()			 
		} 
		 
		self.activated(true) 
	} 
} 

object hole {
	var property position
	method image() = "tomaco.png"
}

object counter {
	// Count the accumulated carrots 
}