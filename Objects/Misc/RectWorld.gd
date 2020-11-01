extends Node2D

enum TYPE {XY, XZ, YZ}
enum NORMAL {LEFT, RIGHT, NORTH, SOUTH, DOWN, UP}

var rects = {TYPE.XY : {NORMAL.LEFT : [], NORMAL.RIGHT : [], NORMAL.NORTH : [], NORMAL.SOUTH : [], NORMAL.DOWN : [], NORMAL.UP : []},
			TYPE.XZ : {NORMAL.LEFT : [], NORMAL.RIGHT : [], NORMAL.NORTH : [], NORMAL.SOUTH : [], NORMAL.DOWN : [], NORMAL.UP : []},
			TYPE.YZ : {NORMAL.LEFT : [], NORMAL.RIGHT : [], NORMAL.NORTH : [], NORMAL.SOUTH : [], NORMAL.DOWN : [], NORMAL.UP : []}}

func clear():
	rects = {TYPE.XY : {NORMAL.LEFT : [], NORMAL.RIGHT : [], NORMAL.NORTH : [], NORMAL.SOUTH : [], NORMAL.DOWN : [], NORMAL.UP : []},
			TYPE.XZ : {NORMAL.LEFT : [], NORMAL.RIGHT : [], NORMAL.NORTH : [], NORMAL.SOUTH : [], NORMAL.DOWN : [], NORMAL.UP : []},
			TYPE.YZ : {NORMAL.LEFT : [], NORMAL.RIGHT : [], NORMAL.NORTH : [], NORMAL.SOUTH : [], NORMAL.DOWN : [], NORMAL.UP : []}}

func _draw():
	if Globals.drawRects:
		var rect2
		for normal in rects[TYPE.XY].values():
			for rect in normal:
				rect2 = Rect2(rect.getFakeXMin(), rect.getFakeYMin() - rect.fakePosition.z / Globals.zScale, rect.fakeXExtent * 2, rect.fakeYExtent * 2)
				draw_rect(rect2, Color(0, 255, 0), false, 1)
		for normal in rects[TYPE.XZ].values():
			for rect in normal:
				rect2 = Rect2(rect.getFakeXMin(), rect.fakePosition.y - (rect.fakeZExtent * 2 / Globals.zScale) * ((rect.fakePosition.z - rect.fakeZExtent) / (rect.fakeZExtent * 2)) - (rect.fakeZExtent * 2 / Globals.zScale), rect.fakeXExtent * 2, (rect.fakeZExtent * 2) / Globals.zScale)
				draw_rect(rect2, Color(255, 0, 0), false, 1)
		for normal in rects[TYPE.YZ].values():
			for rect in normal:
				var start = Vector2(rect.fakePosition.x, rect.getFakeYMax() - (rect.fakeZExtent * 2 / Globals.zScale) * ((rect.fakePosition.z - rect.fakeZExtent) / (rect.fakeZExtent * 2)) - (rect.fakeZExtent * 2 / Globals.zScale))
				var stop = Vector2(rect.fakePosition.x, rect.getFakeYMin() - (rect.fakeZExtent * 2 / Globals.zScale) * ((rect.fakePosition.z - rect.fakeZExtent) / (rect.fakeZExtent * 2)) - (rect.fakeZExtent * 2 / Globals.zScale))
				draw_line(start, stop, Color(0, 0, 255), 1)

func _process(delta):
	update()

class Rect extends Actor:
	var _owner_ = null

	func _init(_fakePosition, _owner = null):
		self.fakePosition = _fakePosition
		self._owner_ = _owner

class XYRect extends Rect:
	var fakeXExtent
	var fakeYExtent

	func _init(_fakePosition, _fakeXExtent, _fakeYExtent, _owner = null).(_fakePosition, _owner):
		._init(_fakePosition, _owner)
		self.fakeXExtent = _fakeXExtent
		self.fakeYExtent = _fakeYExtent
	
	func getFakeXMin():
		return self.fakePosition.x - self.fakeXExtent

	func getFakeXMax():
		return self.fakePosition.x + self.fakeXExtent

	func getFakeYMin():
		return self.fakePosition.y - self.fakeYExtent

	func getFakeYMax():
		return self.fakePosition.y + self.fakeYExtent

class XZRect extends Rect:
	var fakeXExtent
	var fakeZExtent

	func _init(_fakePosition, _fakeXExtent, _fakeZExtent, _owner = null).(_fakePosition, _owner):
		._init(_fakePosition, _owner)
		self.fakeXExtent = _fakeXExtent
		self.fakeZExtent = _fakeZExtent
	
	func getFakeXMin():
		return self.fakePosition.x - self.fakeXExtent

	func getFakeXMax():
		return self.fakePosition.x + self.fakeXExtent

	func getFakeZMin():
		return self.fakePosition.z - self.fakeZExtent

	func getFakeZMax():
		return self.fakePosition.z + self.fakeZExtent

class YZRect extends Rect:
	var fakeYExtent
	var fakeZExtent

	func _init(_fakePosition, _fakeYExtent, _fakeZExtent, _owner = null).(_fakePosition, _owner):
		._init(_fakePosition, _owner)
		self.fakeYExtent = _fakeYExtent
		self.fakeZExtent = _fakeZExtent
	
	func getFakeYMin():
		return self.fakePosition.y - self.fakeYExtent

	func getFakeYMax():
		return self.fakePosition.y + self.fakeYExtent

	func getFakeZMin():
		return self.fakePosition.z - self.fakeZExtent

	func getFakeZMax():
		return self.fakePosition.z + self.fakeZExtent

func _ready():
	pass

func addXYRect(fakePosition, fakeXExtent, fakeYExtent, normal, owner=null):
	# fakePosition: a Vector3 to define the origin (center) of the rect
	var rect = XYRect.new(fakePosition, fakeXExtent, fakeYExtent, owner)
	if not (owner is Character):
		rects[TYPE.XY][normal].append(rect)
	return rect

func addXZRect(fakePosition, fakeXExtent, fakeZExtent, normal, owner=null):
	# fakePosition: a Vector3 to define the origin (center) of the rect
	var rect = XZRect.new(fakePosition, fakeXExtent, fakeZExtent, owner)
	if not (owner is Character):
		rects[TYPE.XZ][normal].append(rect)
	return rect

func addYZRect(fakePosition, fakeYExtent, fakeZExtent, normal, owner=null):
	# fakePosition: a Vector3 to define the origin (center) of the rect
	var rect = YZRect.new(fakePosition, fakeYExtent, fakeZExtent, owner)
	if not (owner is Character):
		rects[TYPE.YZ][normal].append(rect)
	return rect

func getXYRectsIntersectedBy(x : int, y : int, zStart : int, zEnd : float): #Returns all XY rects intersected by the given straight line on the z-axis
	var arr = []									#Note: zStart/End are inclusive, but x and y are not
	
	var zMin
	var zMax
	var normal

	if zStart > zEnd:
		zMax = zStart
		zMin = zEnd
		normal = NORMAL.UP
	else:
		zMax = zEnd
		zMin = zStart
		normal = NORMAL.DOWN

	for rect in rects[TYPE.XY][normal]:
		if x > int(rect.getFakeXMin()) and x < int(rect.getFakeXMax()) and y > int(rect.getFakeYMin()) and y < int(rect.getFakeYMax()):
			if int(rect.fakePosition.z) >= zMin and int(rect.fakePosition.z) <= zMax:
				arr.append(rect)
	
	return arr

func getXZRectsIntersectedBy(x : int, z : int, yStart : int, yEnd : float): #Returns all XZ rects intersected by the given straight line on the y-axis
	var arr = []									#Note: yStart/End are inclusive, but x and z are not
	
	var yMin
	var yMax
	var normal

	if yStart > yEnd:
		yMax = yStart
		yMin = yEnd
		normal = NORMAL.SOUTH
	else:
		yMax = yEnd
		yMin = yStart
		normal = NORMAL.NORTH

	for rect in rects[TYPE.XZ][normal]:
		if x > int(rect.getFakeXMin()) and x < int(rect.getFakeXMax()) and z > int(rect.getFakeZMin()) and z < int(rect.getFakeZMax()):
			if int(rect.fakePosition.y) >= yMin and int(rect.fakePosition.y) <= yMax:
				arr.append(rect)
	
	return arr

func getYZRectsIntersectedBy(y : int, z : int, xStart : int, xEnd : float): #Returns all YZ rects intersected by the given straight line on the x-axis
	var arr = []									#Note: xStart/End are inclusive, but y and z are not
	
	var xMin
	var xMax
	var normal

	if xStart > xEnd:
		xMax = xStart
		xMin = xEnd
		normal = NORMAL.RIGHT
	else:
		xMax = xEnd
		xMin = xStart
		normal = NORMAL.LEFT

	for rect in rects[TYPE.YZ][normal]:
		if y > int(rect.getFakeYMin()) and y < int(rect.getFakeYMax()) and z > int(rect.getFakeZMin()) and z < int(rect.getFakeZMax()):
			if int(rect.fakePosition.x) >= xMin and int(rect.fakePosition.x) <= xMax:
				arr.append(rect)
	
	return arr
