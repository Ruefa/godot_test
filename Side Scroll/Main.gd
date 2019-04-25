extends Node

var Monster = load("res://Monster.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MobSpawnTimer_timeout():
	$MonsterPath/MonsterSpawnLocation.set_offset(randi())
	
	var monster = Monster.instance()
	add_child(monster)
	
	monster.position = $MonsterPath/MonsterSpawnLocation.position