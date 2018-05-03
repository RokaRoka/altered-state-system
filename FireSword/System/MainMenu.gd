extends Control

onready var firstLevel = preload("res://MainScenes/GrassLands.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_PlayButton_down():
	get_tree().change_scene_to( firstLevel )


func _on_QuitButton_down():
	get_tree().quit()
