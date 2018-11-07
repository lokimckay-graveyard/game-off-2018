extends Node

# TODO
const states = {
	"menu": "menu",
	"playing": "playing",
	"paused": "paused",
	"gameover": "gameover"
}

var gameState = states.menu

func updateGameState(newState):
	logger.write("New game state: " + newState)
	gameState = newState

func start():
	updateGameState(states.playing)
	scene_manager.loadScene(scene_manager.scenes.game)

func restart():
	# TODO: Extra reset logic
	start()

func quitToMenu():
	updateGameState(states.menu)
	scene_manager.loadScene(scene_manager.scenes.mainMenu)

func quit():
	scene_manager.quit()