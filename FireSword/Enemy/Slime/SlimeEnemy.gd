extends "res://System/Entity.gd"

#refs to nodes
onready var uiControl = get_node("/root/World/UIControl")

# PHYSICS CONSTANTS #
const GRAVITY_VALUE = -30

const KB_POWER = 10
const KB_TIME = 0.25

const SPEED = 40
const MOVE_FREQ = 1.5 #seconds

# GAMEPLAY VALUES #
const MAX_HEALTH = 4

func _ready():
	health = MAX_HEALTH
	expPoints = 1

func _physics_process( delta ):
	pass #velocity = move_and_slide( velocity, dir.up )

func move():
	#print ("Im a moving enemy!!")
	#random direction
	var randDir = Vector3((randf() * 2.0) - 1.0, 0, (randf() * 2.0) - 1.0)
	
	#move towards dir
	randDir = randDir.normalized() * SPEED
	move_and_slide( randDir )

func _exit_tree():
	if health <= 0:
		uiControl.addEXP(expPoints)

func _on_MoveTimer_timeout():
	move()
