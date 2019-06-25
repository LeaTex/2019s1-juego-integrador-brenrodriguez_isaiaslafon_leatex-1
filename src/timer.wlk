import level.*
import gameController.*
import wollok.game.*

object timer {
	var seconds = 0 
	const positions = [ new Position(0,self.boardCorner()), new Position(1,self.boardCorner()) ]
	
	method reset() { seconds = 0}
	method minutes() = seconds.div(60)
	method seconds() = seconds % 60
	method digitLeft(digit) = digit.div(10)
	method digitRight(digit) = digit % 10
	method minuteLeft() = self.digitLeft(self.minutes())
	method minuteRight() = self.digitRight(self.minutes())
	method secondLeft() = self.digitLeft(self.seconds())
	method secondRight() = self.digitRight(self.seconds())
		
	method increase() { seconds += 1}
	method boardCorner() = gameController.playingLevel().boardSize().y()

	method updateTime() {
		self.increase()
	}
}


