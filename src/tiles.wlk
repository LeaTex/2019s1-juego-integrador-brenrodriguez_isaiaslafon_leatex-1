import wollok.game.*

class Obstacle {
	const property position
	const property image
	
	constructor() = self(game.center().x(), game.center().y(), fenceType.lonelyGrass())
	
	constructor(x,y) =	self(x,y,fenceType.lonelyGrass())
	
	constructor(x,y, _image) { 
		position =  new Position(x,y)
		image = _image
	}
		
	method canBeSteppedOn() = false
	
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

class Grabable {
	var property position
	var property image

	constructor(x,y, _image) { 
		position = new Position (x,y)
		image = _image
	}

	method  canBeSteppedOn () = true
	
	method reactTo(player){
		player.removeCarrot(self)
		game.removeVisual(self)
		game.addVisual(new Hole(position = self.position()))
		game.addVisual(player)
		remainingCarrotsCounter.decrementAndShow()
	}
}

//To implement
/*class Carrot2 inherits Grabable (1,0,carrotIMage) {
	
}*/



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
		player.reDraw()
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

object visual {
	const type = new Dictionary()
	
	method fillTypes() {
		//Player:
		type.put("bobby","./tiles/player/bobbyCarrot.png")
		type.put("deadBobby","./tiles/player/bobbyCarrot.png")
		
		//Obstacles:
			//Fences:
			type.put("horizontalFence","./tiles/fences/horizontalFence.png")
			type.put("verticalFence","./tiles/fences/verticalFence.png")
			type.put("bottomLeftFence","./tiles/fences/bottomLeftFence.png")
			type.put("bottomRightFence","./tiles/fences/bottomRightFence.png")
			type.put("topLeftFence","./tiles/fences/topLeftFence.png")
			type.put("topRightFence","./tiles/fences/topRightFence.png")
			
			//Grasses:
			type.put("lonelyGrass","./tiles/grass/lonelyGrass.png") 
			type.put("middleGrass","./tiles/grass/middleGrass.png")
			type.put("grass1","./tiles/grass/1.png")
			
		
		//Grabables:
		type.put("carrot","./tiles/ground/carrot.png")
		type.put("egg","./tiles/ground/egg.png")
		type.put("goldKey","./tiles/keys/goldKey.png")
		type.put("silverKey","./tiles/keys/silverKey.png")
		type.put("redKey","./tiles/keys/redKey.png")
		
		//Walkable:
			//Deafult Ground:
			type.put("ground","./tiles/ground/ground.png")
			//After Grab:
			type.put("emptyNest","./tiles/ground/emptyNest.png")
			type.put("groundHole","./tiles/ground/groundHole.png")
			
			//Points:
			type.put("startPoint","./tiles/points/spawnPoint.png")
			type.put("endPointOn","./tiles/points/endPointOn.png")
			type.put("endPointOff","./tiles/points/endPointOff.png")
			
		
		//dynamicObstacles:
			//Runaways:
				//L shape:
				type.put("leftDownRunaway","./tiles/runaways/leftDownRunaway.png")
				type.put("leftUpRunaway","./tiles/runaways/leftUpRunaway.png")
				type.put("rightUpRunaway","./tiles/runaways/rightUpRunaway.png")
				type.put("rightDownRunaway","./tiles/runaways/rightDownRunaway.png")
				
				//Straight Shape:
				type.put("horizontalRunaway","./tiles/runaways/horizontalRunaway.png")
				type.put("vertcalRunaway","./tiles/runaways/verticalRunaway.png")
				
			//Transport Belts:
			type.put("upBelt","./tiles/belts/upBelt.png")
			type.put("downBelt","./tiles/belts/downBelt.png")
			type.put("leftBelt","./tiles/belts/leftBelt.png")
			type.put("rightBelt","./tiles/belts/rightBelt.png")			
	}
	
	method get(tile) {
		type.getOrElse (tile,{=> type.get("middleGrass")})
	}
	
	
}