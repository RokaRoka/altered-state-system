extends Spatial

enum SwordState {
	IDLE,
	ATTACK
}

const ANIM_STATES = [
	"Idle",
	"Swing"
]

var hitParticle = preload( "res://System/VFX/HitParticles.tscn" )
var lastHitParticle

#state data
var currentAnimState

var fireActive = false
onready var fireModule = get_node( "Fire" )
onready var fireParticles = get_node( "Fire/FireParticles" )

#animations
onready var animPlayer = get_node("AnimationPlayer")

func _ready():
	switchAnimState( IDLE )

func switchFire():
	if currentAnimState != "Swing":
		fireActive = !fireActive
	if fireActive:
		fireModule.show()
		get_node("/root/World/UIControl").activateFireUI()
	else:
		fireModule.hide()
		get_node("/root/World/UIControl").greyOutFireUI()

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
	fireModule.omni_range = 7
	fireModule.light_energy = 2.25
	
	fireParticles.amount = 50
	fireParticles.speed_scale = 4
	fireParticles.lifetime = 2

func lessFire():
	fireModule.omni_range = 6
	fireModule.light_energy = 1.25
	
	fireParticles.amount = 20
	fireParticles.speed_scale = 2
	fireParticles.lifetime = 1

func createHitParticle( parent ):
	lastHitParticle = hitParticle.instance()
	parent.add_child( lastHitParticle )
	#parent.remove( lastHitParticle )
	#print(String(lastHitParticle.translation))
	#lastHitParticle.global_transform.origin = parent.global_transform.origin
	#print(String(lastHitParticle.translation))
	lastHitParticle.emitting = true

func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"Swing":
			if fireActive:
				lessFire()
			switchAnimState( IDLE )


func _on_SwordHitbox_body_entered(body):
	#print("body is "+body.get_name())
	if body.get_name() == "Enemy":
		body.hit(2)
		createHitParticle(body)
		print("dmg!")