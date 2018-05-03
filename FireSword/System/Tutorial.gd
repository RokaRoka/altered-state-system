extends Panel

#refs
onready var title = get_node( "MarginContainer/VBoxContainer/TutorialTitle" )
onready var text = get_node( "MarginContainer/VBoxContainer/Label" )
onready var fadeTween = get_node( "FadeTween" )
onready var moveTween = get_node( "MoveTween" )

#member variables
#movement related
const TRANSITION_TIME = 1.0

#position
const ON_SCREEN = Vector2(764, 128)
const OFF_SCREEN = Vector2(1080, 128)

var movingIn = false

#fading out
var movingOut = false
var opaqueColor = Color(1.0, 1.0, 1.0, 1.0)
var fadedColor = Color( 1.0, 1.0, 1.0, 0.0)

#tutorial related
var currentIndex = 0
var tutorialTitles = ["Movement", "Attacking", "Experience", "Areas", "Skills", "What now?"]
var tutorialTexts = ["To move in the game, use WASD.",
	"To swing your sword, press Space Bar.",
	"As you attack enemies, you will gain experience. Gain 3 experience points.",
	"There are other ways to gain experience points, such as discovering areas. Move into the road to transition to the next area.",
	"Skills enhance abilities in the game and have multiple purposes. Try pressing tab to cycle through the fire sword skill.",
	"Go explore now! Try attacking, try exploring, reach the highest level!"]

func _ready():
	loadTutorial( 0 )

func _physics_process(delta):
	pass

func loadTutorial( var index ):
	print("Load tutorial!")
	currentIndex = index
	fadeTween.interpolate_property( self, "modulate", opaqueColor, fadedColor, TRANSITION_TIME, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	if not fadeTween.is_active():
        fadeTween.start()

func updateMoveIn():
	title = tutorialTitles[currentIndex]
	text = tutorialTexts[currentIndex]
	moveTween.interpolate_property( self, "rect_position", OFF_SCREEN, ON_SCREEN, TRANSITION_TIME, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	if not moveTween.is_active():
        moveTween.start()

func _on_FadeTween_completed(object, key):
	fadeTween.reset( self, "modulate" )
	fadeTween.remove( self, "modulate")
	updateMoveIn()


func _on_MoveTween_completed(object, key):
	moveTween.remove( self, "rect_position")
	print("Done!")
