extends Node

func _on_Play_Again_pressed():
	game_manager.restart()

func _on_Quit_pressed():
	game_manager.quit()

func _on_Menu_pressed():
	game_manager.quitToMenu()
