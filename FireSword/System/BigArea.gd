extends Spatial

#refs
onready var uiControl = get_node( "/root/World/UIControl" )

#res paths
var areaNotification = preload( "res://System/AreaPanel.tscn" )

# member variables
export (String) var Name = "Default"
export (int) var ExperiencePoints = 1

var newestAreaNotif 

func _ready():
	newAreaEntered()

func newAreaEntered():
	if areaNotification.can_instance():
		print("Can instance. Yay!")
		newestAreaNotif = areaNotification.instance( PackedScene.GEN_EDIT_STATE_DISABLED )
		uiControl.add_child( newestAreaNotif)
		newestAreaNotif.get_node("AreaName").text = Name
	uiControl.addEXP( ExperiencePoints )
