extends Node

export (int) var speed = 400

var velocity = Vector3()
var kinematic_body

func _ready():
    kinematic_body = get_parent()

func get_input():
    velocity = Vector3()
    
    if Input.is_action_pressed('up'):
        velocity.z = -speed
        
    if Input.is_action_pressed('left'):
        velocity.x = -speed
        
    if Input.is_action_pressed('down'):
        velocity.z = speed
        
    if Input.is_action_pressed('right'):
        velocity.x = speed

func _physics_process(delta):
    get_input()
    kinematic_body.move_and_slide(velocity * delta)