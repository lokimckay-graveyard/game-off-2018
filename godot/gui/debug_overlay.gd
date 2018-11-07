extends Panel

func _on_Restart_pressed():
	game_manager.restart()

func _on_Menu_pressed():
	game_manager.quitToMenu()

func _on_Quit_pressed():
	game_manager.quit()
