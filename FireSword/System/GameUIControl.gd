extends Control

onready var healthBar = get_node( "HealthBar" )
onready var expBar = get_node( "EXPBar" )

onready var fireAbilityImage = get_node( "FireAbilityPanel/SpriteAnim" )

func _ready():
	greyOutFireUI()

func greyOutFireUI():
	fireAbilityImage.visible = false

func activateFireUI():
	fireAbilityImage.visible = true

func addEXP(amount):
	expBar.value += amount