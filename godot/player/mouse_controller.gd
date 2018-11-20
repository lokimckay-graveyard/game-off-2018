extends Node

var current_speed = 0.0
export var max_speed = 12.0

export var acceleration = 20
export var deceleration = 40

export var follow_direction_speed = 0.1

var accelerating = false

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
    accelerating = false
    
    if Input.is_action_pressed('up'):
        movement_dir = -1
        accelerating = true
    if Input.is_action_pressed('down'):
        movement_dir = 1
        accelerating = true
        
    if Input.is_action_just_pressed('shoot'):
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
    
    var camera = get_node('../Target/Camera')
    
    #Get mouse position in world coordinates
    var mouse_pos = camera.get_viewport().get_mouse_position()
    var cam_from = camera.project_ray_origin(mouse_pos)
    var world_mouse_pos = cam_from + camera.project_ray_normal(mouse_pos) * camera.global_transform.origin.y
    #Make sure Y axis is set to 0
    world_mouse_pos.y = 0
    
    #Rotate character a bit to follow mouse cursor
    kinematic_body.transform.basis.z = follow_direction(kinematic_body.transform, world_mouse_pos)
    kinematic_body.transform.basis.x = kinematic_body.transform.basis.z.rotated(Vector3(0, 1, 0), PI/2)
    
    #Depending on user input accelerate or decelerate
    current_speed = accelerate_speed(delta)
    
    #Move player forward based on input
    kinematic_body.move_and_collide(kinematic_body.transform.basis.z * movement_dir * current_speed * delta)
    
    #Lock axises to prevent translating player height and let only rotations around Y axis
    kinematic_body.transform = lock_axises(kinematic_body.transform)
    
func accelerate_speed(delta):
    var new_speed = current_speed
    
    if accelerating and current_speed < max_speed:
        new_speed += acceleration * delta
        
        if current_speed > max_speed:
            new_speed = max_speed
            
    if !accelerating and current_speed > 0:
        new_speed -= deceleration * delta
        
        if current_speed < 0:
            new_speed = 0
            
    return new_speed

func follow_direction(transform, direction):
    var basis = transform.basis
    var origin = transform.origin
    
    return basis.z.linear_interpolate((direction - origin).rotated(Vector3(0, 1, 0), -PI).normalized(), 0.1).normalized()
    
func lock_axises(transform):
    transform.basis.x = Vector3(kinematic_body.transform.basis.x.x, 0, kinematic_body.transform.basis.x.z).normalized()
    transform.basis.y = Vector3(0, 1, 0)
    transform.basis.z = Vector3(kinematic_body.transform.basis.z.x, 0, kinematic_body.transform.basis.z.z).normalized()
    
    transform.origin = Vector3(kinematic_body.transform.origin.x, 0, kinematic_body.transform.origin.z)
    
    return transform

# Getters & Setters
func set_player_ammo(value):
    player_ammo = value
func get_player_ammo():
    return player_ammo