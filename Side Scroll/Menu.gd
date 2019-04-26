extends Node2D

# reference to player object
var player

func _ready():
	hide()

func _process(delta):
	pass

func _on_Button_pressed():
	player.att_speed_mult -= .1
	player.statChange()
	
func setPlayer(Player):
	player = Player
