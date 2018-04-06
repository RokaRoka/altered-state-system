extends KinematicBody

#position constants
const VEC3_FORWARD = Vector3( 0, 0, 1 )
const VEC3_LEFT = Vector3( 1, 0, 0 )
const VEC3_UP = Vector3( 0, 1, 0 )

#physics constants
const GRAVITY = Vector3(0, -30, 0)

#editor members
#player speed in pixels per second
export var player_spd = 2

#private members
var buffered_velocity = Vector3()
var input_direction = Vector3()

func _ready():
	pass

func _input(event):
	if event is InputEventKey:
		match event.scancode:
			KEY_W:
				#move forward
				input_direction += (VEC3_FORWARD * player_spd)
			KEY_A:
				#move left
				input_direction += ( VEC3_LEFT * player_spd)
			KEY_D:
				#move right
				input_direction += ( VEC3_LEFT * -1 * player_spd)
			KEY_S:
				#move back
				input_direction += ( VEC3_FORWARD * -1 * player_spd)
		if event.pressed:
			bufferMovement( input_direction )
		else:
			#bufferMovement( input_direction * -1)
			pass

func _physics_process(delta):
	playerMovement()
	#applyGravity()

func playerMovement():
	if buffered_velocity.length_squared() > 0:
		move_and_slide( buffered_velocity )

func bufferMovement(direction):
	buffered_velocity = direction * player_spd

func applyGravity():
	var coll = move_and_collide( GRAVITY )
	if coll != null:
		#do ground collision stuff
		pass