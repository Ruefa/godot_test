extends KinematicBody2D

const MOVE_SPEED = 200

var consts = load("res://Constants.gd")
var velocity = Vector2(0,0)
var curDirection = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	$PauseTimer.start(randi()%3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_on_floor():
		velocity.y += delta*consts.GRAVITY
	else:
		velocity.y = 0
		
	if $PauseTimer.is_stopped() and $MoveTimer.is_stopped():
		$MoveTimer.start(randi()%5+1.5)
		if randi()%2:
			curDirection = 1
			$AnimatedSprite.flip_h = false
		else:
			curDirection = -1
			$AnimatedSprite.flip_h = true
		
	if !$MoveTimer.is_stopped():
		velocity.x = MOVE_SPEED * curDirection
		$AnimatedSprite.play()
	elif is_on_floor(): # keep velocity when in the air
		velocity.x = 0
		$AnimatedSprite.stop()
		$AnimatedSprite.set_frame(0)
	
	move_and_slide(velocity, Vector2(0,-1))

func _on_MoveTimer_timeout():
	$PauseTimer.start(randi()%5)
	
	move_and_slide(velocity, Vector2(0,-1))