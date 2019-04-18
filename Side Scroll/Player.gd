extends Area2D

var SPEED_X = 200
var SCREEN_SIZE
var SPRITE_SIZE

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2()
	SCREEN_SIZE = get_viewport_rect().size
	SPRITE_SIZE = $CollisionShape2D.shape.extents

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity
	if velocity.y > 200:
		velocity.y = 200
	
	if Input.is_action_pressed("ui_up") && velocity.y >= 0:
		velocity.y = -500
		gravity = true
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED_X
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED_X
	else:
		velocity.x = 0
	
	position += velocity * delta
	position.y = clamp(position.y, 0 + SPRITE_SIZE.y, SCREEN_SIZE.y - SPRITE_SIZE.y)


func _on_Ground_area_entered(area):
	velocity.y = 0
	gravity = false
