extends Node

export (int) var speed = 10
export (int) var rotation_speed = 3

var rotation_dir = 0
var movement_dir = 0
var kinematic_body

var root
var raycast
export (PackedScene) var current_weapon = null
var player_ammo = 10 setget set_player_ammo, get_player_ammo

signal drop_weapon

func _ready():
	kinematic_body = get_parent()
	root = kinematic_body.get_parent()
	raycast = kinematic_body.get_node('DetectItem')
	connect("drop_weapon", root, "_on_Player_drop_weapon")
	
func get_input():
	rotation_dir = 0
	movement_dir = 0
	
	if Input.is_action_pressed('up'):
		movement_dir -= 1
	if Input.is_action_pressed('left'):
		rotation_dir += 1
	if Input.is_action_pressed('down'):
		movement_dir += 1
	if Input.is_action_pressed('right'):
		rotation_dir -= 1
		
	if Input.is_action_pressed('shoot'):
		if current_weapon != null:
			current_weapon.get_node('Controller').shoot()
		else:
			logger.write("No weapon.")
			
	if Input.is_action_just_pressed('reload'):
		if current_weapon != null:
			if player_ammo > 0:
				current_weapon.get_node('Controller').reload()
				logger.write("[PLAYER] Ammo: " + str(player_ammo))
			else:
				logger.write("[PLAYER] Out of ammo.")
		else:
			logger.write("No weapon.")
			
	if Input.is_action_just_pressed('equip'):
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			print(collider.name)
			if collider.name.find('Pistol') > -1:
				collider.queue_free()
				current_weapon = load("res://weapons/pistol/pistol.tscn").instance()
				current_weapon.transform = kinematic_body.get_node('Hand').transform
				current_weapon.get_node('Controller').set_weapon_type('Pistol')
				kinematic_body.add_child(current_weapon)
				
	if Input.is_action_just_pressed('unequip'):
		if current_weapon != null:
			emit_signal("drop_weapon", load("res://weapons/pistol/pistol.tscn"), kinematic_body.get_node('Hand').global_transform)
			current_weapon.queue_free()
			current_weapon = null

func _physics_process(delta):
	get_input()
	
	#Rotate player based on input
	kinematic_body.transform.basis = kinematic_body.transform.basis.rotated(Vector3(0, 1, 0), 
	                                                                        rotation_dir * rotation_speed * delta)
	
	#Move player forward based on input
	kinematic_body.move_and_collide(kinematic_body.transform.basis.z * movement_dir * speed * delta)

# Getters & Setters
func set_player_ammo(value):
	player_ammo = value
func get_player_ammo():
	return player_ammo