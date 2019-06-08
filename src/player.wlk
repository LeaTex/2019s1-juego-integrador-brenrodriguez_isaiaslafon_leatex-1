import wollok.game.*

class Player {
	
	var property position = game.center()
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
