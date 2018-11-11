extends Node

export (int) var speed = 10
export (int) var rotation_speed = 3

var rotation_dir = 0
var movement_dir = 0
var kinematic_body

func _ready():
    kinematic_body = get_parent()

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

func _physics_process(delta):
    get_input()
    
    #Rotate player based on input
    kinematic_body.transform.basis = kinematic_body.transform.basis.rotated(Vector3(0, 1, 0), 
                                                                            rotation_dir * rotation_speed * delta)
    
    #Move player forward based on input
    kinematic_body.move_and_collide(kinematic_body.transform.basis.z * movement_dir * speed * delta)