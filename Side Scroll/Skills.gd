extends Node

var skillPoints = 5

var stats = {
	consts.ATT_SPEED : 0,
	consts.ATT_DAMAGE : 0,
	consts.PROJ : 0
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

func getStat(type):
	if type in stats:
		return stats[type]