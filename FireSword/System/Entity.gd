extends KinematicBody

# PHYSICS CONSTANTS #
const GRAVITY_VALUE = -1

const ACCEL = 2
const DEACCEL = 4
const SPEED = 0

# GAMEPLAY CONSTANTS #
const MAX_HEALTH = 5

# PRIVATE MEMBERS #
var health = 0

var expPoints = 0

var velocity = Vector3(0, 0, 0)

func applyGravity():
	velocity.y += GRAVITY_VALUE

func hit( dmgAmount, kbDir = dir.up ):
	#knockbackDir = kbDir
	health -= dmgAmount
	if health <= 0:
		queue_free()
	else:
		pass
		#inHitstun = true
		#hitstunTimer = KB_TIME
