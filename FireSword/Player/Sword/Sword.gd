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

var fireActive = false
onready var fireModule = get_node( "Fire" )
onready var fireParticles = get_node( "Fire/FireParticles" )

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
		if fireActive:
			moreFire()
		return true

func moreFire():
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Swing":
			switchAnimState( IDLE )


func _on_SwordHitbox_body_entered(body):
	#print("body is "+body.get_name())
	if body.get_name() == "Enemy":
		print("Enemy hit, pow!")#body.get_parent().hit(3)