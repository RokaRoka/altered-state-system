extends Position3D

onready var spawnTimer = get_node("SpawnTimer")
var enemyScene = preload( "res://Enemy/Slime/SlimeEnemy.tscn" )

var lastEnemy

func _ready():
	spawn()

func spawn():
	lastEnemy = enemyScene.instance()
	add_child( lastEnemy )
	print("enemy spawn")

func _on_SpawnTimer_timeout():
	#print("woaoaaooa tierout")
	if lastEnemy == null:
		spawn()
