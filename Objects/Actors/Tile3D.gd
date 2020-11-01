extends Actor
class_name Tile3D

enum {FLOOR, WALL}

var plane : RectWorld.Rect
var sprite : Sprite
var biome : int
var transmutable : bool
var transmuteSprite

func _init(_fakePosition : Vector3, orientation : int, xExtent : float, yOrZExtent : float, _sprite : Sprite, _transmutable : bool, _biome : int = Globals.BIOME.NONE):
	fakePosition = _fakePosition
	sprite = _sprite
	transmutable = _transmutable
	biome = _biome
	transmuteSprite = null

	zStart = int(fakePosition.z)
	updateRealPosition()

	if orientation == FLOOR:
		plane = RectWorld.addXYRect(fakePosition, xExtent, yOrZExtent, RectWorld.NORMAL.UP, self)
	else:
		plane = RectWorld.addXZRect(fakePosition, xExtent, yOrZExtent, RectWorld.NORMAL.SOUTH, self)
	
	add_child(sprite)

func getFakeXMin():
	return plane.getFakeXMin()

func getFakeXMax():
	return plane.getFakeXMax()

func getFakeYMin():
	return plane.getFakeYMin()

func getFakeYMax():
	return plane.getFakeYMax()

func getFakeZMin():
	return plane.getFakeZMin()

func getFakeZMax():
	return plane.getFakeZMax()

func getSortY():
	return getFakeYMin()
	



