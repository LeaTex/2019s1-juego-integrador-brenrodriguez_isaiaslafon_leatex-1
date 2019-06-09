import wollok.game.*

class Fence {
	var property position
	var property image
	
	constructor() = self(game.center(), "./tiles/grass/lonelyGrass.png")
	constructor(x,y, _image) = self(new Position(x,y), _image)
	constructor(_position, _image) { 
		position = _position 
		image = _image
	}
	
	method canBeSteppedOn() = false
}

object fenceType {
	method horizontal() = "./tiles/fences/horizontalFence.png" 
	method vertical() = "./tiles/fences/verticalFence.png" 
	method bottomLeft()  =  "./tiles/fences/bottomLeftFence.png"
	method bottomRight() =  "./tiles/fences/bottomRightFence.png"
	method topLeft()  =  "./tiles/fences/topLeftFence.png"
	method topRight()  =  "./tiles/fences/topRightFence.png"
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
		remainingCarrotsCounter.decrementAndShow()
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
	
	method reactTo(player){
		//go to next levelimage
	}
	
	method  canBeSteppedOn () = true
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
	
	var property position = new Position(-1, -1)
	var counter = 0
	method set(cant) {
	 counter = cant		
	}
	
	method decrement() {
	 counter -= 1
	}
	
	method showCounter() {
	 	game.onTick(100, "show counter", { 
   	    game.say(self, "Carrots: " + counter)
  		game.removeTickEvent("show counter")
	})
	
	}
	method image() = "./tiles/grass/middleGrass.png"
	
	method decrementAndShow() {
		self.decrement()
		self.showCounter()
	}
	
	// Count the accumulated carrots 
}