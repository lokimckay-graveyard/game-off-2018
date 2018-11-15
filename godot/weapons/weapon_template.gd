extends Node

var kinematic_body
var weapon_root
var fire_timer
var reload_timer
var hand

var weapon_type = "" setget set_weapon_type, get_weapon_type
export (int) var damage = 1
export (int) var fire_rate = 0.5
export (int) var bullet_spread = 0
export (int) var reload_time = 3
export (int) var weapon_range = -1
export (int) var max_ammo = 5
var current_ammo = 5

signal shoot
export (PackedScene) var bullet = preload("res://weapons/bullet_template.tscn")

func _ready():
	weapon_root = self.get_parent()
	fire_timer = weapon_root.get_node('FireTimer')
	reload_timer = weapon_root.get_node('ReloadTimer')
	
	# Get the weapon specification in the weapon_manager
	var specs = weapon_manager.get_weapon_specs(get_weapon_type())
	if specs != null:
		kinematic_body = weapon_root.get_parent()
		hand = kinematic_body.get_node('Hand')
		
		damage = specs.damage
		fire_rate = specs.fire_rate
		bullet_spread = specs.bullet_spread
		reload_time = specs.reload_time
		weapon_range = specs.weapon_range
		max_ammo = specs.max_ammo
		
		current_ammo = max_ammo
		reload_timer.wait_time = reload_time
		fire_timer.wait_time = fire_rate
		
		# Connect to World
		var root = self.get_parent().get_parent().get_parent()
		logger.write("connect")
		connect("shoot", root, "_on_Player_shoot")
	pass

func shoot():
	logger.write("shoot function")
	
	print(reload_timer.is_stopped())
	print(fire_timer.is_stopped())
	if reload_timer.is_stopped() && fire_timer.is_stopped():
		if current_ammo > 0:
			var direction = -kinematic_body.transform.basis.z
			emit_signal("shoot", bullet, hand.global_transform, direction)
			current_ammo -= 1
			logger.write("[Weapon/Shoot] Ammo: " +  str(current_ammo))
			fire_timer.start()
		else:
			logger.write("[WEAPON] Out of ammo.")

func reload():
	logger.write("reload function")
	
	if reload_timer.is_stopped() && kinematic_body != null:
		var player_ammo = kinematic_body.get_node('Controller').get_player_ammo()
		var difference = max_ammo - current_ammo
		if player_ammo > difference:
			current_ammo += difference
		else:
			current_ammo = player_ammo + current_ammo
		player_ammo -= difference
		if player_ammo < 0:
			player_ammo = 0
		kinematic_body.get_node('Controller').set_player_ammo(player_ammo)
		logger.write("[Weapon/Reload] Ammo: " +  str(current_ammo))
		reload_timer.start()
	pass

func unequip():
	weapon_root.queue_free()

# Getters & Setters
func set_weapon_type(value):
	weapon_type = value
func get_weapon_type():
	return weapon_type
