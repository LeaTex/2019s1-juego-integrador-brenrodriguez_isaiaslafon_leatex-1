import wollok.game.*

class Wall {
	var property position
	
	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }
    
    method image() = "./tiles/fences/fenceHorizontal.png"

	method canBeSteppedOn() = false

}
class Fence {
	var property position
	var fenceImage = "./tiles/fences/fenceHorizontal.png"
	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = fenceImage

	method showHorizontal() = "./tiles/fences/horizontalFence.png"
	method showVertical() = "./tiles/fences/verticalfence.png"
	method showBottomLeft() = "./tiles/fences/leftFence.png"
	method showBottomRigh() = "./tiles/fences/roghtFence.png"
	method showTopLeftUp() = "./tiles/fences/leftUpFence.png"
	method showTopRighUp() = "./tiles/fences/rightUpFence.png"
	
	method canBeSteppedOn() = false

}



class Grass {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = "./tiles/grass/middleGrass.png"

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
		game.addVisual(player)
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
	method canBeSteppedOn () = true 
	method reactTo(player){}
}

object remainingCarrotsCounter {
	var counter
	method set(cant) {
	 counter = cant		
	}
	
	method decrement() {
	 counter -= counter		
	}
	
	method showCounter() {
	 	game.say(self, "Carrots: " + counter)
	}
	
	method decrementAndShow() {
		self.decrement()
		self.showCounter()
	}
	
	// Count the accumulated carrots 
}