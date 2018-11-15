extends Node

var parent

export (int) var speed = 10
export (int) var damage

var velocity = Vector3()

func _ready():
	parent = self.get_parent()

func start(_position, _direction):
#	print(_position)
#	print(_direction)
	parent.transform = _position
	velocity = _direction * speed
	pass

func _process(delta):
	parent.translation += velocity * delta
	pass

func _on_VisibilityNotifier_screen_exited():
	parent.queue_free()
	pass # replace with function body
