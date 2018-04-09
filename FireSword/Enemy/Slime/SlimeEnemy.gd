extends KinematicBody

# MOVEMENT DATA #
const SPEED = 50

const MOVE_FREQ = 1.5 #seconds

# GAMEPLAY VALUES #


func _ready():
	pass


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
