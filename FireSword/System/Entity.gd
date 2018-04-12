extends KinematicBody

# PHYSICS CONSTANTS #
const GRAVITY_VALUE = -1

const SPEED = 0

const KB_POWER = 0
const KB_TIME = 0

# GAMEPLAY CONSTANTS #
const MAX_HEALTH = 5

# PRIVATE MEMBERS #
var health = 0

var expPoints = 0

var knockbackDir = Vector3()
var inHitstun = false
var hitstunTimer = 0

var velocity = Vector3(0, 0, 0)
var grounded = false

func applyGravity( delta ):
	velocity.y += GRAVITY_VALUE * delta

func applyHitstun(delta):
	#velocity += knockbackDir * KB_POWER
	hitstunTimer -= delta
	if hitstunTimer < 0:
		inHitstun = false

func hit( dmgAmount, kbDir = dir.up ):
	if not inHitstun:
		#knockbackDir = kbDir
		health -= dmgAmount
		if health <= 0:
			queue_free()
		else:
			inHitstun = true
			hitstunTimer = KB_TIME

