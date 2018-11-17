extends Node

# TODO
const states = {
	"menu": "menu",
	"playing": "playing",
	"paused": "paused",
	"gameover": "gameover"
}

var gameState = states.menu
var gameoverMenu

func _ready():
	gameoverMenu = load("res://menu/gameover_menu.tscn").instance()
	gameoverMenu.set_name("GameoverMenu")

func reset():
	# Add any game reset logic (e.g. score & enemies etc.) here
	remove_child(gameoverMenu)

func updateGameState(newState):
	logger.write("New game state: " + newState)
	gameState = newState

func start():
	updateGameState(states.playing)
	scene_manager.loadScene(scene_manager.scenes.game)

func restart():
	reset()
	start()

func gameover():
	updateGameState(states.gameover)
	add_child(gameoverMenu)
	# Show GO menu

func quitToMenu():
	reset()
	updateGameState(states.menu)
	scene_manager.loadScene(scene_manager.scenes.mainMenu)

func quit():
	scene_manager.quit()