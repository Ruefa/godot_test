extends KinematicBody2D

const SPEED = 450

signal kill(node)

var damage
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
		if collision.get_collider() in enemyNodes:
			if collision.get_collider().hit(damage):
				emit_signal("kill", (collision.get_collider()))
			queue_free()
			break
		else:
			queue_free()


func _on_DespawnTimer_timeout():
	queue_free()
