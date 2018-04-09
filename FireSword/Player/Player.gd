extends KinematicBody

#physics constants
const GRAVITY = Vector3(0, -30, 0)

#editor members
#player speed in pixels per second
export var player_spd = 128

#private members
var buffered_velocity = Vector3()
var input_direction = Vector3()

var buffered_attack = 0
const ATTACK_BUFFER = 6 + 1 #1 is added since the frame you press the input, 1 gets eaten

#weapon related
#current weapon is the child of "weapon" node
onready var currentWeapon = get_node( "Weapon" ).get_child(0)

func _ready():
	pass

func _physics_process(delta):
	input_direction = Vector3()
	bufferMovement()
	bufferAttack()
	
	playerMovement(delta)
	if buffered_attack > 0:
		playerAttack()
	#applyGravity()

# INPUT RELATED #

func bufferMovement():
	if Input.is_action_pressed( "player_up" ):
		input_direction += (dir.forward)
	if Input.is_action_pressed( "player_left" ):
		input_direction += (dir.left)
	if Input.is_action_pressed( "player_right" ):
		input_direction += ( dir.left * -1)
	if Input.is_action_pressed( "player_down" ):
		input_direction += ( dir.forward * -1)

func bufferAttack():
	if Input.is_action_just_pressed( "player_attack" ):
		buffered_attack = ATTACK_BUFFER

# FUNCTIONAL RELATED #

func playerMovement(delta):
	if input_direction.length_squared() > 0:
		move_and_slide( input_direction * player_spd * delta)

func playerAttack():
	if currentWeapon.tryAttack():
		buffered_attack = 0
	else:
		buffered_attack -= 1

func applyGravity():
	var coll = move_and_collide( GRAVITY )
	if coll != null:
		#do ground collision stuff
		pass