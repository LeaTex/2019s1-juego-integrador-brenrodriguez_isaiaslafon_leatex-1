import wollok.game.*
import gameController.*
import gameAssets.*

class BasicObstacle {
	const property image
	
	constructor(_image) { 
		image = _image
	}
		
	method canBeSteppedOn() = false
}

class Obstacle inherits BasicObstacle{
	const property position
		
	constructor(x,y) =	self(x,y, assets.get("lonelyGrass"))
	
	constructor(x,y, _image) = super(_image) { 
		position =  new Position(x,y)
	}
		
}

class Fence {
	var property position
	var property image
	
	constructor() = self(game.center().x(), game.center().y(), fenceType.lonelyGrass())
	
	constructor(x,y) =	self(x,y,fenceType.lonelyGrass())
	
	constructor(x,y, _image) { 
		position =  new Position(x,y)
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
	method lonelyGrass() = "./tiles/grass/lonelyGrass.png"
}

class Grass {
	const property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = "./tiles/grass/middleGrass.png"

	method canBeSteppedOn() = false

}

class BasicGrabbable {
	const property image
	
	constructor(_image) { 
		image = _image
	}

	method  canBeSteppedOn () = true
	
	method reactTo(player)
}

class Grabbable inherits BasicGrabbable{
	var property position
	
	constructor(x,y, _image) = super (_image) { 
		position = new Position (x,y)
	}
}


/*
class CarrotA inherits BasicGrabbable {
	const property position
	
	constructor(x,y) = super (assets.get("carrot")) { 
		position = new Position (x,y)
	}
	
	override method reactTo(player) {}
} 
*/


class Key inherits Grabbable {
	const property lock
		
	constructor(x,y, aLock, _image) = super (x,y,_image) { 
		lock = aLock
	}

	override method reactTo(player){
		lock.remove()
		game.removeVisual(self)
	}
}

class Lock inherits BasicObstacle{
	var property position
	
	constructor(x,y, _image) = super(_image) { 
		position = new Position (x,y)
	}
}

//this are implemented as objects cause can be or not on the map but they only change position and always are "linked" with the same object.
object goldLock inherits Lock(0,0, assets.get("goldLock")) {}
object silverLock inherits Lock(0,0, assets.get("silverLock")) {}
object redLock inherits Lock(0,0, assets.get("redLock")) {}

object goldKey inherits Key(0,0, goldLock, assets.get("goldKey")) {}
object silverKey inherits Key(0,0, silverLock, assets.get("silverKey")) {}
object redKey inherits Key(0,0, redLock, assets.get("redKey")) {}



class Carrot {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = assets.get("carrot")

	method  canBeSteppedOn () = true
	
	method reactTo(player){
		game.removeVisual(self)
		game.addVisual(new Hole(position = self.position()))
		player.collectCarrot(self)
		gameController.carrotCollected()
	}
}

	
class EndPoint {
	var property position
	var image = assets.get("endPointOff")
	var levelComplete = false
	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }
	
	method image() = image 
	
	method endPointOn() {
		image = assets.get("endPointOn")
		levelComplete = true
	}
	method endPointOff() {
		image = assets.get("endPointOff")
		levelComplete = false
	}	

	method reactTo(player){
		//go to next levelimage
		//game.say(self , "Well done!")
		
		if (levelComplete) {
			levelComplete = false
			game.onTick(1000, "levelComplete", {
			game.say(player , "Wohooo!") 
  			gameController.goToNextLevel()
			})
		}

	}
	
	method  canBeSteppedOn () = true
}

class Trap { 
	var property activated = false 
	var property position 
	 
	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }
	 
	method image() = if (activated) assets.get("spikesUp") else assets.get("spikesDown") 
	 
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
	method image() = assets.get("groundHole")
	method canBeSteppedOn () = true 
	method reactTo(player){}
}

/*
object remainingCarrotsCounter {
	
	var property position = new Position(-1, -1)
	var counter = 0
	method set(cant) {
	 counter = cant		
	}
	
	method decrement() {
	 counter -= 1
	}
	
	method showCounter() {game.say(self, "Carrots: " + counter)}

	method image() = "./tiles/grass/middleGrass.png"
	
	method decrementAndShow() {
		self.decrement()
		self.showCounter()
	}
}
*/