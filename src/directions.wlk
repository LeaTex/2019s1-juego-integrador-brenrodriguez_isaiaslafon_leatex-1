//Not used yet
class Direction {
	method nextDirectionClockwise() = {}
	method nextDirectionCounterClockwise() = {}
	method opossiteDirection() = {}
}

object up inherits Direction {
	override method nextDirectionClockwise() = right  
	override method nextDirectionCounterClockwise() = left
	override method opossiteDirection() = down
}

object left inherits Direction {
	override method nextDirectionClockwise() = up  
	override method nextDirectionCounterClockwise() = down
	override method opossiteDirection() = right
}

object down inherits Direction {
	override method nextDirectionClockwise() = left
	override method nextDirectionCounterClockwise() = right 
	override method opossiteDirection() = up
}

object right inherits Direction {
	override method nextDirectionClockwise() = down  
	override method nextDirectionCounterClockwise() = up 
	override method opossiteDirection() = left
}
