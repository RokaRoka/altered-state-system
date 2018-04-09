extends Spatial

enum SwordState {
	IDLE,
	ATTACK
}

const SWORD_STATE_STRINGS = [
	"Idle",
	"Swing"
]

#state data
var currentSwordState

#animations
onready var animPlayer = get_node("AnimationPlayer")

func _ready():
	currentSwordState = IDLE
	animPlayer.play( SWORD_STATE_STRINGS[currentSwordState] )

func _physics_process(delta):
	#if Input.is_action_just_pressed( 
	if Input.is_key_pressed( KEY_SPACE ):
		switchState( ATTACK )

func switchState( newState ):
	currentSwordState = newState
	animPlayer.play( SWORD_STATE_STRINGS[newState] )


