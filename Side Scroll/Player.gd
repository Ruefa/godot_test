extends KinematicBody2D

const GRAVITY = 200
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
	SPRITE_SIZE = $CollisionShape2D.shape.extents*.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# gravity
	velocity.y += delta*GRAVITY
	
	# left - right movement
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED_X
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED_X
	else:
		velocity.x = 0
	
	move_and_slide(velocity, Vector2(0,-1))
