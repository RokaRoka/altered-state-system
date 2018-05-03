extends Control

#export variables
export (bool) var tutorialOn = true

#refs
onready var healthBar = get_node( "HealthBar" )
onready var expBar = get_node( "EXPBar" )
onready var level = get_node( "Level" )

onready var player = get_node("/root/World/Player")

onready var tutorialPanel = get_node( "TutorialPanel" )
onready var fireAbilityImage = get_node( "FireAbilityPanel/SpriteAnim" )

enum Skills {
	SKILL_FIRE
}

const MAX_LEVEL = 5
var levelUpSkills = []


#Member variables
var playerLevel = 1
var playerSkills = {
	SKILL_FIRE : false
}

func _init():
	#set up level skills
	levelUpSkills.resize( MAX_LEVEL )
	levelUpSkills[1] = SKILL_FIRE

func _ready():
	if tutorialOn:
		tutorialPanel.show()
	greyOutFireUI()

func greyOutFireUI():
	fireAbilityImage.visible = false

func activateFireUI():
	fireAbilityImage.visible = true

func addEXP( amount ):
	if playerLevel < MAX_LEVEL:
		player.experienceGain( amount )
		expBar.value += amount
		if expBar.ratio >= 1.0:
			expBar.value -= expBar.max_value
			levelUp()
	
	if tutorialOn:
		if tutorialPanel.currentIndex == 2 and expBar.value >= 3:
			tutorialPanel.loadTutorial( 3 )
		elif tutorialPanel.currentIndex == 3:
			tutorialPanel.loadTutorial( 4 )

func levelUp():
	playerLevel += 1
	level.text = "Level " + String(playerLevel)
	newSkillGet()

func newSkillGet():
	var skill = levelUpSkills[playerLevel]
	if playerSkills.has(skill):
		playerSkills[skill] = true
	pass # replace with function body
