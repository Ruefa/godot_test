extends KinematicBody2D

const SPEED = 450
var velocity = Vector2(SPEED, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(velocity, Vector2(0,-1))
	
	if get_slide_count() > 0:
		queue_free()


func _on_DespawnTimer_timeout():
	queue_free()
