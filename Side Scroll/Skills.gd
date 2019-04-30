extends Node

var skillPoints = 5

var att_speed_mult = 0

#func _ready():

func allocateSkill(type, value):
	att_speed_mult += value
	skillPoints -= 1
