extends TileMap
class_name TileMap3D

enum {CENTER, BORDER_LEFT, BORDER_RIGHT, BORDER_TOP, BORDER_TOPLEFT, BORDER_TOPRIGHT, WALL}
export(int) var zLayer
export(bool) var floorsOnly

var rect

var tileDefinitions = {CENTER : [],
						BORDER_LEFT : [],
						BORDER_RIGHT : [],
						BORDER_TOP : [],
						BORDER_TOPLEFT : [],
						BORDER_TOPRIGHT : [],
						WALL : []}

func generateSpriteFromCell(cell) -> Sprite:
	var spr = Sprite.new()
	var autotileCoord = get_cell_autotile_coord(cell.x, cell.y)

	spr.region_enabled = true
	spr.set_texture(tile_set.tile_get_texture(get_cellv(cell)))
	spr.region_rect = Rect2(autotileCoord.x * cell_size.x, autotileCoord.y * cell_size.y, cell_size.x, cell_size.y)
	spr.z_as_relative = true

	return spr

func defineTiles():
	pass

func _ready():
	rect = get_used_rect()
	defineTiles()
	convertToPlanesAndTile3Ds()

"""
func constructRects(rectTiles : Dictionary):
	for _zLayer in rectTiles[RectWorld.TYPE.XY]:
		var optimizedXYRects = RectOptimizer.optimize(rectTiles[RectWorld.TYPE.XY][_zLayer])
		for rect in optimizedXYRects:
			var flatPos : Vector2 = rect[0]
			var xLength : int = rect[1]
			var yLength : int = rect[2]
			var sprites : Array = rect[3]
			
			var fakePos = Vector3(flatPos.x * cell_size.x + (cell_size.x / 2), flatPos.y * cell_size.y + (cell_size.y / 2), _zLayer * cell_size.y * Globals.zScale)
			var fakeXExtent = (xLength * cell_size.x) / 2
			var fakeYExtent = (yLength * cell_size.y) / 2
			RectWorld.addXYRect(fakePos, fakeXExtent, fakeYExtent)

	for yLayer in rectTiles[RectWorld.TYPE.XZ]:
		var optimizedXZRects = RectOptimizer.optimize(rectTiles[RectWorld.TYPE.XZ][yLayer])
		for rect in optimizedXZRects:
			var flatPos : Vector2 = rect[0]
			var xLength : int = rect[1]
			var zLength : int = rect[2]
			var sprites : Array = rect[3]
			
			var fakePos = Vector3(flatPos.x * cell_size.x + (cell_size.x / 2), yLayer * cell_size.y, (flatPos.y * cell_size.y * Globals.zScale) / 2)
			var fakeXExtent = (xLength * cell_size.x) / 2
			var fakeZExtent = (zLength * cell_size.y * Globals.zScale) / 2
			RectWorld.addXZRect(fakePos, fakeXExtent, fakeZExtent)

	for xLayer in rectTiles[RectWorld.TYPE.YZ]:
		var optimizedYZRects = RectOptimizer.optimize(rectTiles[RectWorld.TYPE.YZ][xLayer])
		for rect in optimizedYZRects:
			var flatPos : Vector2 = rect[0]
			var yLength : int = rect[1]
			var zLength : int = rect[2]
			
			var fakePos = Vector3(xLayer * cell_size.x, flatPos.x * cell_size.x + (cell_size.x / 2), (flatPos.y * cell_size.y * Globals.zScale) / 2)
			var fakeYExtent = (yLength * cell_size.y) / 2
			var fakeZExtent = (zLength * cell_size.y * Globals.zScale) / 2
			RectWorld.addYZRect(fakePos, fakeYExtent, fakeZExtent)

class RectOptimizer:
	static func optimize(rectTiles : Array) -> Array:
		var rects = []
	
		var minCol = rectTiles[0][0].x
		var maxCol = minCol
		var minRow = rectTiles[0][0].y
		var maxRow = minRow
	
		for rectTile in rectTiles:
			var coord = rectTile[0]
	
			if coord.x < minCol:
				minCol = coord.x
			elif coord.x > maxCol:
				maxCol = coord.x
	
			if coord.y < minRow:
				minRow = coord.y
			elif coord.y > maxRow:
				maxRow = coord.y
		
		var grid = []
	
		for y in range(minRow, maxRow + 1):
			var row = []
			for x in range(minCol, maxCol + 1):
				row.append(null)
			grid.append(row)
	
		for rectTile in rectTiles:
			var coord = rectTile[0]
			grid[coord.y][coord.x] = rectTile
			
		var rects = []

		for rectTile in rectTiles:
			var coord = rectTile[0]
			var sprites
			if rectTile[1] == null:
				sprites = []
			else:
				sprites = [rectTile[1]]
			rects.append([coord, 1, 1, sprites])
		
		return rects
"""

func convertToPlanesAndTile3Ds():
	for cell in get_used_cells():

		var cellType

		if floorsOnly:
			cellType = CENTER
		else:
			var autotileCoord = get_cell_autotile_coord(cell.x, cell.y)
			for type in tileDefinitions:
				if (str(autotileCoord.x) + "," + str(autotileCoord.y)) in tileDefinitions[type]:
					cellType = type
					break

		if cellType != WALL:
			var fakePos = Vector3()
			fakePos.x = map_to_world(cell).x + cell_size.x / 2
			fakePos.y = map_to_world(cell).y + cell_size.y / 2 + (cell_size.y * zLayer)
			fakePos.z = zLayer * cell_size.y * Globals.zScale

			var tile = Tile3D.new(fakePos, Tile3D.FLOOR, cell_size.x / 2, cell_size.y / 2, generateSpriteFromCell(cell), true)
			add_child(tile)

			if cellType == BORDER_LEFT or cellType == BORDER_TOPLEFT:
				fakePos.x = map_to_world(cell).x
				fakePos.y = map_to_world(cell).y + cell_size.y / 2 + (cell_size.y * zLayer)
				fakePos.z = (zLayer * cell_size.y * Globals.zScale) - (cell_size.y * Globals.zScale) / 2

				RectWorld.addYZRect(fakePos, cell_size.y / 2, (cell_size.y / 2) * Globals.zScale, RectWorld.NORMAL.LEFT)

			if cellType == BORDER_RIGHT or cellType == BORDER_TOPRIGHT:
				fakePos.x = map_to_world(cell).x + cell_size.x
				fakePos.y = map_to_world(cell).y + cell_size.y / 2 + (cell_size.y * zLayer)
				fakePos.z = (zLayer * cell_size.y * Globals.zScale) - (cell_size.y * Globals.zScale) / 2

				RectWorld.addYZRect(fakePos, cell_size.y / 2, (cell_size.y / 2) * Globals.zScale, RectWorld.NORMAL.RIGHT)

			if cellType == BORDER_TOP or cellType == BORDER_TOPLEFT or cellType == BORDER_TOPRIGHT:
				fakePos.x = map_to_world(cell).x + cell_size.x / 2
				fakePos.y = map_to_world(cell).y + (cell_size.y * zLayer)
				fakePos.z = (zLayer * cell_size.y * Globals.zScale) - (cell_size.y * Globals.zScale) / 2

				RectWorld.addXZRect(fakePos, cell_size.y / 2, (cell_size.y / 2) * Globals.zScale, RectWorld.NORMAL.NORTH)
		else:
			var fakePos = Vector3()
			fakePos.x = map_to_world(cell).x + cell_size.x / 2
			fakePos.y = map_to_world(cell).y + (cell_size.y * zLayer)
			fakePos.z = (zLayer * cell_size.y * Globals.zScale) - (cell_size.y * Globals.zScale) / 2

			var tile = Tile3D.new(fakePos, Tile3D.WALL, cell_size.y / 2, (cell_size.y / 2) * Globals.zScale, generateSpriteFromCell(cell), true)
			add_child(tile)
		
		set_cellv(cell, -1)
