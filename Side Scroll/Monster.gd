extends KinematicBody2D

var consts = load("res://Constants.gd")
var velocity = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_on_floor():
		velocity.y += delta*consts.GRAVITY
	else:
		velocity.y = 0
	
	move_and_slide(velocity, Vector2(0,-1))