extends Node2D

func _ready():
	hide()

func _process(delta):
	# pause menu
	if Input.is_action_pressed("ui_menu"):
		if get_tree().paused:
			get_tree().paused = false
			hide()
		else:
			get_tree().paused = true
			show()

func _on_Button_pressed():
	print("you pressed me")
