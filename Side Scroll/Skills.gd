extends Node

var skillPoints = 5

var att_speed_mult = 0

#func _ready():

func allocateSkill(type, value):
	if skillPoints > 0:
		att_speed_mult += value
		skillPoints -= 1
		
		return true
	else:
		return false
