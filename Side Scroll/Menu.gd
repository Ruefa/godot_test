extends Node2D

# reference to player object
var player

func _ready():
	hide()

func _process(delta):
	pass
	
func setPlayer(Player):
	player = Player


func _on_Damage_pressed():
	player.damage_mult += .1
	player.statChange()


func _on_AttSpeed_pressed():
	var skills = player.get_node("Skills")
	if skills.skillPoints > 0:
		skills.allocateSkill("attSpeed", -.1)
		player.statChange()
	else:
		print("no skill points")
