import wollok.game.*

class Wall {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = "spot.png"

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

object hole {
	var property position
	method image() = "tomaco.png"
}

object counter {
	// Count the accumulated carrots 
}