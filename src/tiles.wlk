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


class GrabbableKey inherits Grabbable {
	const property lock
		
	constructor(x,y, aLock, _image) = super (x,y,_image) { 
		lock = aLock
	}

	override method reactTo(player){
		game.removeVisual(lock)
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

object goldKey inherits GrabbableKey(0,0, goldLock, assets.get("goldKey")) {}
object silverKey inherits GrabbableKey(0,0, silverLock, assets.get("silverKey")) {}
object redKey inherits GrabbableKey(0,0, redLock, assets.get("redKey")) {}



class Carrot inherits GameObject {

	override method image() = assets.get("carrot")

	override method  canBeSteppedOn () = true
	
	override method reactTo(player){
		game.removeVisual(self)
		player.collect()
		gameController.carrotCollected()
	}
}

	
class EndPoint inherits GameObject {
	var image = assets.get("endPointOff")
	var levelComplete = false
	
	override method image() = image 
	
	method endPointOn() {
		image = assets.get("endPointOn")
		levelComplete = true
	}
	method endPointOff() {
		image = assets.get("endPointOff")
		levelComplete = false
	}	

	override method reactTo(player){
		//go to next levelimage
		//game.say(self , "Well done!")
		
		if (levelComplete) {
			
			levelComplete = false
			game.onTick(1000, "levelComplete", {
				game.removeTickEvent("levelComplete")
				game.say(player , "Wohooo!") 
  				gameController.goToNextLevel()
			})
		}

	}
	
	override method  canBeSteppedOn () = true
}

class Trap inherits GameObject { 
	var activated = false 
	 
	override method image() = if (activated) assets.get("spikesUp") else assets.get("spikesDown") 
	 
	override method canBeSteppedOn () = true 
	
	method disable() { activated = false}
	
	method change() { activated = not activated} 
	
	override method reactTo(player) { 
		if (activated) { 
			player.die()		 
		}  
	}
} 


//the runway is incomplete
class Runway inherits GameObject {
	var property isVerticalPosition = false
		
	override method image() = if (isVerticalPosition) assets.get("verticalRunway") else assets.get("horizontalRunway")
	
	method change() { isVerticalPosition = not isVerticalPosition} 
	
	override method canBeSteppedOn () = true 
	
	override method reactTo(player){ } 
	
}

class Hole inherits GameObject {
	override method image() = assets.get("groundHole")
	override method canBeSteppedOn () = true 
	override method reactTo(player) { }
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

class Belt inherits GameObject {
	
	var property beltType = 0
	
	constructor(x,y,type) = super(x,y) {
		beltType = type
		position = new Position(x,y)
	}
			
	override method image() = if (beltType == 0) assets.get("leftBelt") else if (beltType == 1) assets.get("rightBelt") else if(beltType == 2) assets.get("downBelt")  else return assets.get("upBelt")
	
	override method canBeSteppedOn () = true
	 
	override method reactTo(player){
		
		if (beltType == 0) {
			player.move(player.position().right(1))
		} else if (beltType == 1) {
			player.move(player.position().left(1))
		} else if (beltType == 2) {
			player.move(player.position().down(1))
		} else {
			player.move(player.position().up(1))
		}
	}
}

class GameObject { 
	var property position 
	constructor() = self(game.center()) 
	constructor(x,y) = self(new Position(x,y)) 
	constructor(_position) { position = _position } 
	method image()
	method canBeSteppedOn ()  
	method reactTo(player)
} 