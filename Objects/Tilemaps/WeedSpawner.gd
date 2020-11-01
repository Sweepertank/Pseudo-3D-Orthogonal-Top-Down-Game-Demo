extends TileMap


var weed = load("res://Objects/Actors/Environment/Outside/Weed.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for cell in get_used_cells():
		var inst = weed.instance()
		inst.position = map_to_world(cell) + Vector2(8, 8)
		add_child(inst)
		set_cellv(cell, -1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
