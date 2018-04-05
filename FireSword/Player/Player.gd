extends KinematicBody

#position constants
const VEC3_FORWARD = Vector3( 0, 0, 1 )
const VEC3_LEFT = Vector3( 1, 0, 0 )
const VEC3_UP = Vector3( 0, 1, 0 )

#editor members
export var player_spd = 50

#private members
var buffered_velocity = Vector3()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if event is InputEventKey:
		playerMovement( event.scancode )

func _physics_process(delta):
	pass

func playerMovement(key):
	match key:
		KEY_W:
			#move forward
			move_and_slide( VEC3_FORWARD * player_spd)
		KEY_A:
			#move left
			move_and_slide( VEC3_LEFT * player_spd)
		KEY_D:
			#move right
			move_and_slide( VEC3_LEFT * -1 * player_spd)
		KEY_S:
			#move back
			move_and_slide( VEC3_FORWARD * -1 * player_spd)

