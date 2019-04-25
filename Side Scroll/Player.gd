extends KinematicBody2D

var Bullet = load("res://Bullet.tscn")

const GRAVITY = 500
const RIGHT = 'right'
const LEFT = 'left'

var SPEED_X = 200
var SCREEN_SIZE
var PLAYER_DIR = RIGHT

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2()
	SCREEN_SIZE = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# gravity
	if !is_on_floor():
		velocity.y += delta*GRAVITY
	else:
		velocity.y = 0
		
	if is_on_ceiling() and velocity.y < 0:
		velocity.y = 0
	
	# handle collisions
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		#print(collision.get_normal().y)
#		# if touching the ground turn off gravity
#		if collision.get_normal().y < 0:
#			velocity.y = 0

	# left - right movement
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED_X
		PLAYER_DIR = RIGHT
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED_X
		PLAYER_DIR = LEFT
	else:
		velocity.x = 0
		
	if Input.is_action_pressed("ui_shoot") and $FireRateTimer.is_stopped():
		playerShoot()
		
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -400

	
	move_and_slide(velocity, Vector2(0,-1))
	

func playerShoot():
	$FireRateTimer.start()
	
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	add_collision_exception_with(bullet)
	bullet.position = position
	bullet.position.x += SPRITE_SIZE.x*3

