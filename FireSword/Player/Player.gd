extends "res://System/Entity.gd"

#refs to nodes
onready var uiControl = get_node("/root/World/UIControl")

# PHYSICS CONSTANTS #
const ACCEL = 3
const DEACCEL = 8

#editor members
#player speed in meters per second
export var player_spd = 10
export var player_turn_spd = 5 #in degrees

#private members
var input_direction = Vector3()

var buffered_attack = 0
const ATTACK_BUFFER = 6 + 1 #1 is added since the frame you press the input, 1 gets eaten

#weapon related
#current weapon is the child of "weapon" node
onready var currentWeapon = get_node( "Weapon" ).get_child(0)

#health realted
const MAX_HEALTH = 10

func _ready():
	health = MAX_HEALTH

func _physics_process(delta):
	input_direction = Vector3()
	
	bufferMovement()
	bufferSwitch()
	bufferAttack()
	
	if buffered_attack > 0:
		playerAttack()
	
	playerMovement( delta )		
	applyGravity()
	
	if Input.is_key_pressed( KEY_E ):
		print("before vel " + String(velocity))
	
	velocity = move_and_slide( velocity, dir.up )
	
	if Input.is_key_pressed( KEY_E ):
		print("after vel " + String(velocity))

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

func bufferSwitch():
	if Input.is_action_just_pressed( "player_switch" ):
		currentWeapon.switchFire()

func bufferAttack():
	if Input.is_action_just_pressed( "player_attack" ):
		buffered_attack = ATTACK_BUFFER

# FUNCTIONAL RELATED #

func playerMovement( delta ):	
	var hvel = velocity
	hvel.y = 0
	
	var target = input_direction.normalized() * player_spd
	var accel
	if (input_direction.dot(hvel) > 0):
		accel = ACCEL
	else:
		accel = DEACCEL
	
	hvel = hvel.linear_interpolate(target, accel * delta)
	
	velocity.x = hvel.x
	velocity.z = hvel.z
	if input_direction.length_squared() > 0:
		playerRotateOnMove()

func playerRotateOnMove():
	var newVector = Vector3()
	#print (String( atan2(input_direction.x, input_direction.z)/PI + 0.5) + " Radians")
	newVector.y = atan2(input_direction.x, input_direction.z) #+ 0.5*PI
	rotation = newVector
	#print(String(angle))

func playerAttack():
	if currentWeapon.tryAttack():
		buffered_attack = 0
	else:
		buffered_attack -= 1
