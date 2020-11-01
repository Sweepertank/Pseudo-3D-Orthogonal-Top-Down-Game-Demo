extends Panel

var item = null
onready var textureRect = $TextureRect
var testItemResource = load("res://Objects/Resources/Items/TestItem.tres")
var testItemResource2 = load("res://Objects/Resources/Items/TestItem2.tres")

func _ready():
	randomize()
	var num = randi() % 3
	if num == 0:
		item = testItemResource
	elif num == 1:
		item = testItemResource2

	if item != null:
		textureRect.texture = item.texture
	else:
		textureRect.texture = null

func clearItem():
	item = null
	textureRect.texture = null

func setItem(_item):
	item = _item
	textureRect.texture = item.texture
