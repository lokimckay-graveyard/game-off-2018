extends Node

# source: http://docs.godotengine.org/en/stable/getting_started/step_by_step/singletons_autoload.html

var scenes = {
		"mainMenu": "res://menu/main_menu.tscn",
		"game": "res://game.tscn"
	}

var current_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)

func loadScene(path):
	logger.write("Loading scene: " + path)
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func quit():
	get_tree().quit()