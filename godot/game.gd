extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Player_shoot(bullet, _position, _direction):
	var new_bullet = bullet.instance()
	self.add_child(new_bullet)
	new_bullet.get_node('Controller').start(_position, _direction)
	pass

func _on_Player_drop_weapon(weapon, _position):
	var dropped_weapon = weapon.instance()
	self.add_child(dropped_weapon)
	dropped_weapon.transform = _position
	pass