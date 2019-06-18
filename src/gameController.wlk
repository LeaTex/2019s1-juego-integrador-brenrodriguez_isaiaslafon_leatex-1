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

		self.initializeGameForLevel(levelsList.level(3))
	}

	method initializeGameKeyboard() {
		keyboard.q().onPressDo { game.stop() } // quit
		keyboard.r().onPressDo { self.restartLevel() } // restart
		keyboard.h().onPressDo { self.showHelp() } // help
	}
	method initializePlayerKeyboard() {
		var player = playingLevel.player()
		keyboard.w().onPressDo { player.move(player.position().up(1)) }
		keyboard.s().onPressDo { player.move(player.position().down(1)) }
		keyboard.a().onPressDo { player.move(player.position().left(1)) }
		keyboard.d().onPressDo { player.move(player.position().right(1)) }
	}
	
	method restartLevel() {
		playingLevel.restart()
		self.initializeGameForLevel(playingLevel)
	}

	method goToNextLevel() {
		self.initializeGameForLevel(playingLevel.nextLevel())
	}

	method initializeGameForLevel(aLevel) {
		game.clear()
		playingLevel = aLevel
		playingLevel.prepareGameAccordingToMap(game)

		self.initializeGameKeyboard()
		self.initializePlayerKeyboard()
		self.carrotCollected()
	}
	
	method carrotCollected(){
		var endPoint = playingLevel.map().endPoint()
		var remainingCarrotsAmount = playingLevel.remainingCarrotsAmount()
		
		if (remainingCarrotsAmount > 0)
			game.say(endPoint , "Carrots left: " + remainingCarrotsAmount)
		else {
			endPoint.endPointOn()
			game.say(endPoint , "Ready to go!")
		}
	}
	
	method showHelp() {
		var helpMessage
		helpMessage = "Q - Quit the game | "
		helpMessage += "R - Restart the game\n"
		helpMessage += "H - Shows this help | "
		helpMessage += "AWSD - Moves Bobby"

		error.throwWithMessage(helpMessage)
		//game.say(playingLevel.bunny() , helpMessage)
		console.println(helpMessage)
	}
}
