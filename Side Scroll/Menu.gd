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
	updateSkillLabel()
		

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
		skillNode.get_node("Label").text = skillNode.type
		skillNode.connect("pressed", self, "_on_skillNode_pressed", [skillNode])
		skillNode.margin_top = 50 + skill.y*(50 + skillNode.get_normal_texture().get_height())
		skillNode.margin_left = 25 + skill.x*(25 + skillNode.get_normal_texture().get_width())
		add_child(skillNode)


func _on_skillNode_pressed(event):
	print("pressed")
	if player.get_node("Skills").allocateSkill(event.type, event.value):
		updateSkillLabel()
		player.statChange()
	else:
		# show error for not enough SP
		print("no SP")
	
func updateSkillLabel():
	$Skill_Points_Label.text = str(player.get_node("Skills").skillPoints)
