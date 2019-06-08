import wollok.game.*

class Player {
	var property position

	constructor() = self(game.center())
	constructor(x,y) = self(new Position(x,y))
	constructor(_position) { position = _position }

	method image() = "player.png"
	
	method canMoveTo(nuevaPosicion) {
		var objects = game.getObjectsIn(nuevaPosicion)	
		return objects.isEmpty() or objects.first().canBeSteppedOn()
	} 
	
	method move(nuevaPosicion) {
		if (self.canMoveTo(nuevaPosicion)) {
			 self.position(nuevaPosicion)	
		}
	}	
}
