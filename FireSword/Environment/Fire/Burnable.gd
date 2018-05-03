extends StaticBody

onready var fire = get_node( "Fire" )

#member variables
var health = 5



func fireHit( dmgAmount ):
	if not fire.visible:
		fire.show()
	hit(dmgAmount)

func hit( dmgAmount ):
	#knockbackDir = kbDir
	health -= dmgAmount
	if health <= 0:
		queue_free()

func fire():
	pass