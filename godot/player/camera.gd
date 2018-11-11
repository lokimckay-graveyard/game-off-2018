extends Camera

func _ready():
    #Ignore parent transformation to don't rotate camera
    set_as_toplevel(true)
    
func _physics_process(delta):
    var target = get_parent()
    
    #Due to ignoring transformations move camera manually
    #in two axis X and Z
    translation.x = target.global_transform.origin.x
    translation.z = target.global_transform.origin.z