extends CanvasLayer

var Skill_Node = load("res://Skill_Node.tscn")

# reference to player object
var player

var size = Vector2(714, 401)
var tabList

func _ready():
	# set x and y margins to display the menu in the center of the screen
	$ColorRect.set_margin(MARGIN_LEFT, (get_viewport().size.x - size.x)/2)
	$ColorRect.set_margin(MARGIN_RIGHT, $ColorRect.margin_left + size.x)
	
	$ColorRect.set_margin(MARGIN_TOP, (get_viewport().size.y - size.y)/2)
	$ColorRect.set_margin(MARGIN_BOTTOM, $ColorRect.margin_top + size.y)
	
	tabList = [$ColorRect/Skills, $ColorRect/Character]
	
	# iterate through tabs and set their size and color equal to the main ColorRect
	for tab in tabList:
		tab.color = $ColorRect.color
		tab.get_rect().size = $ColorRect.get_rect().size
		tab.hide()
		
	# show default tab
	$ColorRect/Skills.show()

	hide()
	createSkillTree()
	
func hide():
	$ColorRect.hide()
	
func show():
	$ColorRect.show()

#func _process(delta):
	#pass
	
func setPlayer(Player):
	player = Player
	updateSkillLabel()
		

# generate skill tree from JSON file
func createSkillTree():
	var treeDict = consts.loadJSON("res://JSON/skill_tree.json")
	
	# iterate through each skill and create a button for the player to click
	for skill in treeDict:
		var skillNode = Skill_Node.instance()
		skillNode.type = skill["type"]
		skillNode.value = float(skill["value"])
		skillNode.get_node("Label").text = skillNode.type
		skillNode.connect("pressed", self, "_on_skillNode_pressed", [skillNode])
		skillNode.margin_top = 50 + skill.y*(50 + skillNode.get_normal_texture().get_height())
		skillNode.margin_left = 25 + skill.x*(25 + skillNode.get_normal_texture().get_width())
		$ColorRect/Skills.add_child(skillNode)


func _on_skillNode_pressed(event):
	print("pressed")
	if player.get_node("Skills").allocateSkill(event.type, event.value):
		updateSkillLabel()
		player.statChange()
	else:
		# show error for not enough SP
		print("no SP")
	
func updateSkillLabel():
	$ColorRect/Skills/Skill_Points_Label.text = str(player.get_node("Skills").skillPoints)

func hideTabs():
	for tab in tabList:
		tab.hide()

func _on_Skills_Tab_pressed():
	hideTabs()
	$ColorRect/Skills.show()


func _on_Character_Tab_pressed():
	hideTabs()
	$ColorRect/Character.show()
