extends Node

func _on_New_Game_pressed():
	game_manager.start()


func _on_Quit_pressed():
	game_manager.quit()
