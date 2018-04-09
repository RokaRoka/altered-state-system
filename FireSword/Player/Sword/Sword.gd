extends Spatial

enum SwordState {
	IDLE,
	ATTACK
}

const ANIM_STATES = [
	"Idle",
	"Swing"
]

#state data
var currentAnimState

#animations
onready var animPlayer = get_node("AnimationPlayer")

func _ready():
	switchAnimState( IDLE )

func switchAnimState( newState ):
	currentAnimState = ANIM_STATES[newState]
	animPlayer.play( ANIM_STATES[newState] )

func tryAttack():
	if currentAnimState == ANIM_STATES[ATTACK]:
		return false
	else:
		switchAnimState( ATTACK )
		return true


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Swing":
			switchAnimState( IDLE )
