import wollok.game.*

class Wall {

	var property position = game.center()

	method image() = "spot.png"

	method canBeSteppedOn() = false

}



class Grass {

	var property position = game.center()

	method image() = "spot.png"

	method canBeSteppedOn() = false

}



class Carrot {
	
	var property position = game.center()

	method image() = "spot.png"

	method  canBeSteppedOn () = true

}



class Endpoint {

}

