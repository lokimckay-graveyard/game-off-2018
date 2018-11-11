extends Node

export (int) var speed = 10

var movement_dir = 0
var kinematic_body

func _ready():
    kinematic_body = get_parent()

func get_input():
    movement_dir = 0
    
    if Input.is_action_pressed('up'):
        movement_dir = -1
    if Input.is_action_pressed('down'):
        movement_dir = 1

func _physics_process(delta):
    get_input()
    
    var camera = get_node('../Target/Camera')
    var mouse_pos = get_viewport().get_mouse_position()
    
    var world_mouse_pos = camera.project_position(mouse_pos)
    
    #Get projected mouse position with ignoring height (Y axis)
    var target = Vector3(world_mouse_pos.x, 0, world_mouse_pos.z)
    
    kinematic_body.look_at(target, Vector3(0,1,0))
    
    #Move player forward based on input
    kinematic_body.move_and_collide(kinematic_body.transform.basis.z * movement_dir * speed * delta)