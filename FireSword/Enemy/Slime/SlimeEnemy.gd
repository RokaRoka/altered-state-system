extends "res://System/Entity.gd"

# PHYSICS CONSTANTS #
const GRAVITY_VALUE = -30

const KB_POWER = 10
const KB_TIME = 0.25

const SPEED = 40
const MOVE_FREQ = 1.5 #seconds

# GAMEPLAY VALUES #
const MAX_HEALTH = 4

func _ready():
	pass

func _physics_process( delta ):
	#test for hit working
	if Input.is_action_just_pressed( "player_attack" ):
		hit( 1 )
		
	if inHitstun:
		applyHitstun()
	applyGravity( delta )
	
	velocity = move_and_slide( velocity, dir.up )

func move():
	print ("Im a moving enemy!!")
	#random direction
	var randDir = Vector3((randf() * 2.0) - 1.0, 0, (randf() * 2.0) - 1.0)
	#change rotation to dir
	#global_rotate( Vector3.AXIS_Y, )
	
	#move towards dir
	randDir = randDir.normalized() * SPEED
	move_and_slide( randDir )



func _on_MoveTimer_timeout():
	move()
