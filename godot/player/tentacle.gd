extends MeshInstance

var shoot_range = 10
var repulse_range = 4

var already_in_use = false
var can_repulse = false

var player
var camera
var shoot_tween
var repulse_tween

func _ready():
    player = get_parent()
    camera = get_node('../Target/Camera')
    shoot_tween = get_node("ShootTween")
    repulse_tween = get_node("RepulseTween")
    
func _input(event):
    if event.is_action_pressed('mouse_left_click'):
        if can_repulse:
            repulse()
    if event.is_action_pressed('mouse_right_click'):
        if !already_in_use:
            shoot()
    
func shoot():
    already_in_use = true
    
    var collision_shape = get_node('../CollisionShape')
    
    var mouse_pos = camera.get_viewport().get_mouse_position()
    var cam_from = camera.project_ray_origin(mouse_pos)
    var cam_to = cam_from + camera.project_ray_normal(mouse_pos) * camera.translation.y
    
    #We only interested in X and Z axis
    cam_to.y = 0
    
    var from = Vector3(player.translation.x, 0, player.translation.z)
    var to = (cam_to - from).normalized() * shoot_range
    
    var space_state = player.get_world().direct_space_state
    
    #Raycast tentacle trajectory
    var result = space_state.intersect_ray(from, to, [ collision_shape ])
    
    #Check if tentacle found any attachment point
    if result:
        #Move player smoothly to collision point
        shoot_tween.interpolate_property(player, 'translation', player.translation, 
                                   result.position, 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
        
        shoot_tween.start()
        
    else:
        already_in_use = false
        
func repulse():
    can_repulse = false
    
    var mouse_pos = camera.get_viewport().get_mouse_position()
    var cam_from = camera.project_ray_origin(mouse_pos)
    var cam_to = cam_from + camera.project_ray_normal(mouse_pos) * camera.translation.y
    
    #We only interested in X and Z axis
    cam_to.y = 0
    
    var from = Vector3(player.translation.x, 0, player.translation.z)
    var to = (cam_to - from).normalized() * repulse_range
    
    repulse_tween.interpolate_property(player, 'translation', player.translation, 
                               player.translation + to, 0.2, Tween.TRANS_QUAD, Tween.EASE_OUT)
        
    repulse_tween.start()

func _on_ShootTween_tween_completed(object, key):
    already_in_use = false
    can_repulse = true


func _on_RepulseTween_tween_completed(object, key):
    can_repulse = false
