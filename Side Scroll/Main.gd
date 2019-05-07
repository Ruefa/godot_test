extends Node

var Monster = load("res://Monster.tscn")
var curMap

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	$Menu.setPlayer($Player)
	
	curMap = $Map1/FG
	setCameraLimits()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# pause menu
	if Input.is_action_pressed("ui_menu"):
		if get_tree().paused:
			get_tree().paused = false
			$Menu.hide()
		else:
			get_tree().paused = true
			$Menu.updateSkillLabel()
			$Menu.show()


func _on_MobSpawnTimer_timeout():
	$MonsterPath/MonsterSpawnLocation.set_offset(randi())
	
	var monster = Monster.instance()
	add_child(monster)
	
	monster.position = $MonsterPath/MonsterSpawnLocation.position
	
	
func setCameraLimits():
	$Player/Camera.limit_top = 0
	$Player/Camera.limit_bottom = curMap.get_used_rect().size.y * curMap.cell_size.y
	
	$Player/Camera.limit_left = 0
	$Player/Camera.limit_right = curMap.get_used_rect().size.x * curMap.cell_size.x