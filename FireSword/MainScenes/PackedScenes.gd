extends Node

var grassLands = preload("res://MainScenes/GrassLands.tscn")
var coldCavern = preload("res://MainScenes/TestWorld.tscn")
var mainMenu = preload("res://MainScenes/MainMenu.tscn")

var scenes = {
	"GrassLands" : grassLands,
	"ColdCavern" : coldCavern,
	"MainMenu" : mainMenu
}

func getScene( sceneName ):
	if scenes.has( sceneName ):
		return scenes[sceneName]
	else:
		return scenes["MainMenu"]