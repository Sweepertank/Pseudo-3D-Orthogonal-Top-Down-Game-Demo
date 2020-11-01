extends Node2D

onready var uiRoot : CanvasLayer = $UI
var playerHUD = null

onready var levelRoot : Node2D = $Level
var level = null

func _ready():
	#enablePlayerHUD()
	setLevel(Globals.LEVELS.OUTSIDE_1)

func enablePlayerHUD():
	if playerHUD == null:
		var resource = load("res://Objects/UI/PlayerHUD/PlayerHUD.tscn")
		playerHUD = resource.instance()
	uiRoot.add_child(playerHUD)

func setLevel(id):
	if level != null:
		level.queue_free()
	
	var resource = load(Globals.levelPaths[id])
	
	RectWorld.clear()

	level = resource.instance()
	levelRoot.add_child(level)
