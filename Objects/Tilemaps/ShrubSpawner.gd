extends TileMap


var bush = load("res://Objects/Actors/Environment/Outside/Bush.tscn")
var tree = load("res://Objects/Actors/Environment/Outside/Tree.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for cell in get_used_cells():
		var id = get_cellv(cell)
		var tileName = tile_set.tile_get_name(id)
		var inst
		if "BushWithShadow" in tileName:
			inst = bush.instance()
			inst.position = map_to_world(cell) + Vector2(16, 20)
		elif "TreeWithShadow.png" in tileName:
			inst = tree.instance()
			inst.position = cell + Vector2(16, 39)
		#inst.zStart = 16
		add_child(inst)
		set_cellv(cell, -1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
