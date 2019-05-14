extends Node

const GRAVITY = 500

# stat constants
const ATT_SPEED = "att_speed"
const ATT_DAMAGE = "att_damage"
const PROJ = "projectile"

func loadJSON(fileName):
	var JsonFile = File.new()
	JsonFile.open(fileName, JsonFile.READ)
	
	# parse json into text map
	var JsonDict = JSON.parse(JsonFile.get_as_text()).result
	JsonFile.close()
	
	return JsonDict