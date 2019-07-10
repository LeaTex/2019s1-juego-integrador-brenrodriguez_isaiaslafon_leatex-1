import wollok.game.*
import player.*
import tiles.*
import level.*

object gameController {
	var property playingLevel
	
	method iniciar() {
		game.title("Bobby carrot")
		game.ground("./tiles/ground/ground.png")

		game.width(levelsList.maxPlaygroundSize().x())
		game.height(levelsList.maxPlaygroundSize().y())

		self.initializeGameForLevel(levelsList.level(1))
	}

	method initializeGameKeyboard() {
		keyboard.q().onPressDo { game.stop() } // quit
		keyboard.r().onPressDo { self.restartLevel() } // restart level
		keyboard.n().onPressDo { self.goToNextLevel() } // next level
		keyboard.h().onPressDo { self.showHelp() } // help
	}
	
	method initializePlayerKeyboard() {
		var player = playingLevel.player()
		keyboard.w().onPressDo { player.move(player.position().up(1)) }
		keyboard.s().onPressDo { player.move(player.position().down(1)) }
		keyboard.a().onPressDo { player.move(player.position().left(1)) }
		keyboard.d().onPressDo { player.move(player.position().right(1)) }
		keyboard.up().onPressDo { player.move(player.position().up(1)) }
		keyboard.down().onPressDo { player.move(player.position().down(1)) }
		keyboard.left().onPressDo { player.move(player.position().left(1)) }
		keyboard.right().onPressDo { player.move(player.position().right(1)) }
	}
	
	method restartLevel() {
		playingLevel.restart()
		self.initializeGameForLevel(playingLevel)
	}

	method goToNextLevel() {
		self.initializeGameForLevel(playingLevel.nextLevel())
		self.restartLevel() //added to fix bug after rerun levels previously played
	}
	
	method updateTraps(aPosition) { playingLevel.updateTraps(aPosition) }
	
	method initializeGameForLevel(aLevel) {
		game.clear()
		playingLevel = aLevel
		playingLevel.prepareGameAccordingToMap(game)

		self.initializeGameKeyboard()
		self.initializePlayerKeyboard()
		self.carrotCollected()
	}
	
	method endPoint() = playingLevel.map().endPoint()
	
	method remainingCarrotsAmount() = playingLevel.remainingCarrotsAmount()
	
	method carrotCollected(){
		if (self.remainingCarrotsAmount() == playingLevel.initialCarrotsAmount())
			game.say(self.endPoint() , "Level " + playingLevel.levelNumber())
		if (self.remainingCarrotsAmount() > 0)
			game.say(self.endPoint() , "Carrots left: " + self.remainingCarrotsAmount())
		else {
			self.endPoint().endPointOn()
			game.say(self.endPoint(), "Ready to go!")
		}
	}
	
	method showHelp() {
		var helpMessage
		helpMessage = "Q- Quit the game | "
		helpMessage += "R- Restart the game\n"
		helpMessage += "N- Next level | "
		helpMessage += "H- Shows this help | "
		helpMessage += "AWSD- Moves Bobby"

		error.throwWithMessage(helpMessage)
		//game.say(playingLevel.bunny() , helpMessage)
		//console.println(helpMessage)
	}
}
