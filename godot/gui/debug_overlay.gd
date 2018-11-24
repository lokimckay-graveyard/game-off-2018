extends Panel

var controller_dropdown

const controller_types = {
	"0": 'res://player/mouse_controller.tscn',
	"1": 'res://player/wsad_controller.tscn',
	"2": 'res://player/keyboard_controller.tscn'
}

func _ready():
    controller_dropdown = get_node('MarginContainer/VBoxContainer/Movement')
    
    _setup_controller_dropdown()

func _on_Restart_pressed():
	game_manager.restart()

func _on_Menu_pressed():
	game_manager.quitToMenu()

func _on_Gameover_pressed():
	game_manager.gameover()
    
func _on_Damage_pressed():
    var health = scene_manager.current_scene.get_node('Player/Health')
    health.decrease(1)


func _on_Heal_pressed():
    var health = scene_manager.current_scene.get_node('Player/Health')
    health.increase(1)

func _on_Quit_pressed():
	game_manager.quit()
    
func _on_Movement_item_selected(ID):
    call_deferred('_change_controller_type', controller_types[String(ID)])
    
func _setup_controller_dropdown():
    controller_dropdown.add_item('Mouse Rot.')
    controller_dropdown.add_item('WSAD')
    controller_dropdown.add_item('Keys Rot.')
    
func _change_controller_type(path):
    var player = scene_manager.current_scene.get_node('Player')
    var old_controller = player.get_node('Controller')
        
    old_controller.free()
        
    var new_controller = ResourceLoader.load(path).instance()
    player.add_child(new_controller)
