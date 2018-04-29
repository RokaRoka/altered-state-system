extends Panel

#refs
onready var moveTween = get_node( "MoveTween" )
onready var stayTimer = get_node( "StayTimer" )
onready var fadeTween = get_node( "FadeTween" )

# class member variables go here, for example:
#movement related
const TRANSITION_TIME = 1.0

#position
const ON_SCREEN = Vector2(512, 175)
const OFF_SCREEN = Vector2(1080, 175)

var movingIn = false

#fading out
var movingOut = false
var opaqueColor = Color(1.0, 1.0, 1.0, 1.0)
var fadedColor = Color( 1.0, 1.0, 1.0, 0.0)

func _ready():
	updateMoveIn()
	print("new area yay!")


func _process(delta):
	pass

func updateMoveIn():
	moveTween.interpolate_property( self, "rect_position", OFF_SCREEN, ON_SCREEN, TRANSITION_TIME, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	if not moveTween.is_active():
        moveTween.start()

func updateMoveOut():
	fadeTween.interpolate_property( self, "modulate", opaqueColor, fadedColor, TRANSITION_TIME, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	if not fadeTween.is_active():
        fadeTween.start()


func _on_MoveTween_completed(object, key):
	stayTimer.start()	

func _on_StayTimer_timeout():
	updateMoveOut()

func _on_FadeTween_completed(object, key):
	queue_free()
