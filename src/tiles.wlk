import wollok.game.*

class Wall {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = "./tiles/grass/middleGrass.png"

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

	method image() = "./tiles/ground/carrot.png"

	method  canBeSteppedOn () = true
	
	method reactTo(player){
		player.removeCarrot(self)
		game.removeVisual(self)
		game.addVisual(new Hole(position = self.position()))
	}
}


class EndPoint {
	var property position
	var image = "./tiles/points/endPointOff.png"
	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }
	
	method image() = image 
	
	method endPointOn() {
	image = "./tiles/points/endPointOff.png"
	}
	
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
	 
	method image() = if (activated) "./tiles/spikes/spikesUp.png" else "./tiles/spikes/spikesDown.png" 
	 
	method  canBeSteppedOn () = true 
	 
	 
	method reactTo(player) { 
		 
		if (self.activated()) { 
			game.say(self, "activada") 
			player.receivedDamage()			 
		} 
		 
		self.activated(true) 
	} 
} 

class Hole {
	var property position
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }
	method image() = "./tiles/ground/groundHole.png"
}

object counter {
	// Count the accumulated carrots 
}