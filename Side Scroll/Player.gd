extends KinematicBody2D

var Bullet = load("res://Bullet.tscn")
var consts = load("res://Constants.gd")

const RIGHT = 'right'
const LEFT = 'left'
const BASE_ATT_SPEED = .5
const BASE_DAMAGE = 50
const EXP_TO_LEVEL = 100
const BASE_HP = 100

var SPEED_X = 200
var SCREEN_SIZE
var PLAYER_DIR = RIGHT
var att_speed_mult = 1
var damage_mult = 1
var damage
var curExp = 0
var curHP = BASE_HP
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
	# create vector object for player velocity
	velocity = Vector2()
	
	# get current screen size
	SCREEN_SIZE = get_viewport_rect().size
	
	# apply player stats
	statChange()
	setHP(BASE_HP)
	setXP(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# gravity
	if !is_on_floor():
		velocity.y += delta*consts.GRAVITY
	else:
		velocity.y = 0
	
	# set players y velocity to 0 if player is moving up and hits something above them
	if is_on_ceiling() and velocity.y < 0:
		velocity.y = 0

	# left - right movement
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED_X
		PLAYER_DIR = RIGHT
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play()
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED_X
		PLAYER_DIR = LEFT
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play()
	# stop if no buttons being pressed
	else:
		velocity.x = 0
		$AnimatedSprite.stop()
		$AnimatedSprite.set_frame(0)
		
	# check for player shooting input
	if Input.is_action_pressed("ui_shoot") and $FireRateTimer.is_stopped():
		playerShoot()
		
	# only allow the player to jump when they are on the floor
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -400
		
	# check for collision with an enemy
	# TODO: add player health
	var enemyNodes = get_tree().get_nodes_in_group("Enemy")
	if $VulnTimer.is_stopped():
		for collider in $MonsterArea.get_overlapping_bodies():
			if collider in enemyNodes:
				setHP(curHP - collider.damage)
				$VulnTimer.start()

	# set player to move
	move_and_slide(velocity, Vector2(0,-1))
	

# spawn a bullet and set direction based on player direction
func playerShoot():
	$FireRateTimer.start()
	
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.position = position
	bullet.damage = damage
	bullet.connect("kill", self, "onKill")
	if PLAYER_DIR == LEFT:
		bullet.velocity.x *= -1
		
# called when stats change to recalculate player ability
func statChange():
	$FireRateTimer.set_wait_time(BASE_ATT_SPEED * att_speed_mult + $Skills.att_speed_mult)
	damage = BASE_DAMAGE * damage_mult
	
	# HP
	#$HUD/HealthBar.max_value= BASE
	
func setHP(hp):
	if hp <= 0:
		curHP = 0
		# TODO handle death
		print("You died")
	else:
		curHP = hp
	
	$HUD/HealthBar.max_value = BASE_HP
	$HUD/HealthBar.value = curHP
	
func setXP(xp):
	curExp = xp
	if curExp >= EXP_TO_LEVEL:
		levelUp()
	
	$HUD/ExpBar.max_value = EXP_TO_LEVEL
	$HUD/ExpBar.value = curExp
	
	
func onKill(node):
	setXP(curExp + node.BASE_EXP)
	
		
func levelUp():
	$Skills.skillPoints += 1
	curExp -= EXP_TO_LEVEL

