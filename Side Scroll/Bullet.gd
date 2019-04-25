extends KinematicBody2D

const SPEED = 450

# Called when the node enters the scene tree for the first time.
func _ready():
	add_collision_exception_with($Player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(Vector2(SPEED,0), Vector2(0,-1))
	
	if get_slide_count() > 0:
		queue_free()


func _on_DespawnTimer_timeout():
	queue_free()