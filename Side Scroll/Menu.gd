extends Node2D

var Skill_Node = load("res://Skill_Node.tscn")

# reference to player object
var player

func _ready():
	hide()
	createSkillTree()

#func _process(delta):
	#pass
	
func setPlayer(Player):
	player = Player
	$Skill_Points_Label.text = str(player.get_node("Skills").skillPoints)


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
		

# generate skill tree from JSON file
func createSkillTree():
	var treeFile = File.new()
	treeFile.open("res://JSON/skill_tree.json", treeFile.READ)
	
	# parse json into text map
	var treeDict = JSON.parse(treeFile.get_as_text()).result
	treeFile.close()
	
	# iterate through each skill and create a button for the player to click
	for skill in treeDict:
		var skillNode = Skill_Node.instance()
		skillNode.type = skill["type"]
		skillNode.value = float(skill["value"])
		skillNode.connect("pressed", self, "_on_skillNode_pressed", [skillNode])
		add_child(skillNode)


func _on_skillNode_pressed(event):
	print("pressed")
	player.get_node("Skills").allocateSkill(event.type, event.value)
	player.statChange()
