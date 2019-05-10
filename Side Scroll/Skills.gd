extends Node

var consts = load("res://Constants.gd")

var skillPoints = 5

var stats = {
	consts.ATT_SPEED : 0,
	consts.ATT_DAMAGE : 0
}

#func _ready():

func allocateSkill(type, value):
	if skillPoints > 0:
		if type in stats:
			stats[type] += value
		skillPoints -= 1
		
		return true
	else:
		return false
