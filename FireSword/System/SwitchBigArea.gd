extends Area

export (PackedScene) var NewArea
export (String) var NewAreaFilename

func _ready():
	pass

func _on_SwitchBigArea_body_entered(body):
	if body.get_name() == "Player":
		print("Moving player to "+ NewAreaFilename)
		if PackedScenes.getScene( NewAreaFilename ).can_instance():
			print("Can instance, yay!")
		get_tree().change_scene_to( PackedScenes.getScene( NewAreaFilename ) )