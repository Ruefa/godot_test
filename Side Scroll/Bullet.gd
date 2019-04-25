extends KinematicBody2D

const SPEED = 450
const DAMAGE = 50

var velocity = Vector2(SPEED, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(velocity, Vector2(0,-1))
	
	var enemyNodes = get_tree().get_nodes_in_group("Enemy")
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print(collision.get_collider().name)
		if collision.get_collider() in enemyNodes:
			collision.get_collider().hit(DAMAGE)
			queue_free()
			break
		else:
			queue_free()


func _on_DespawnTimer_timeout():
	queue_free()
