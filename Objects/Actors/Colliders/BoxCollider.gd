extends Collider
class_name BoxCollider

var collisionSlices : Vector3 # The number of times to "slice" each plane on each axis when retrieving vertices, such that higher values yield more vertices

func _init(_fakePosition : Vector3, _fakeExtents : Vector3, _collisionSlices, _owner : Actor).(_fakePosition, _fakeExtents):
	._init(_fakePosition, _fakeExtents)

	collisionSlices = _collisionSlices

	var left = RectWorld.addYZRect(_fakePosition - Vector3(fakeExtents.x, 0, 0), fakeExtents.y, fakeExtents.z, RectWorld.NORMAL.LEFT, _owner)
	var right = RectWorld.addYZRect(_fakePosition + Vector3(fakeExtents.x, 0, 0), fakeExtents.y, fakeExtents.z, RectWorld.NORMAL.RIGHT, _owner)
	var north = RectWorld.addXZRect(_fakePosition - Vector3(0, fakeExtents.y, 0), fakeExtents.x, fakeExtents.z, RectWorld.NORMAL.NORTH, _owner)
	var south = RectWorld.addXZRect(_fakePosition + Vector3(0, fakeExtents.y, 0), fakeExtents.x, fakeExtents.z, RectWorld.NORMAL.SOUTH, _owner)
	var bottom = RectWorld.addXYRect(_fakePosition - Vector3(0, 0, fakeExtents.z), fakeExtents.x, fakeExtents.y, RectWorld.NORMAL.DOWN, _owner)
	var top = RectWorld.addXYRect(_fakePosition + Vector3(0, 0, fakeExtents.z), fakeExtents.x, fakeExtents.y, RectWorld.NORMAL.UP, _owner)
	
	planes = [south, north, left, right, top, bottom]

func _draw():
	if Globals.drawVolumes:
		var rect2 = Rect2(self.getFakeXMin() - global_position.x, self.getFakeYMin() - self.getFakeZMax() - global_position.y, self.fakeExtents.x * 2, self.fakeExtents.y * 2)
		draw_rect(rect2, Globals.GREEN, false, 1)

		rect2 = Rect2(self.getFakeXMin() - global_position.x, self.getFakeYMin() - self.getFakeZMin() - global_position.y, self.fakeExtents.x * 2, self.fakeExtents.y * 2)
		draw_rect(rect2, Globals.GREEN, false, 1)

		"""
		var rect = self.front
		var rect2 = Rect2(rect.getFakeXMin() - global_position.x, rect.fakePosition.y - (rect.fakeZExtent * 2 / Globals.zScale) - global_position.y, rect.fakeXExtent * 2, (rect.fakeZExtent * 2) / Globals.zScale)
		draw_rect(rect2, Color(255, 0, 0), false, 1)

		rect = self.back
		rect2 = Rect2(rect.getFakeXMin() - global_position.x, rect.fakePosition.y - (rect.fakeZExtent * 2 / Globals.zScale) - global_position.y, rect.fakeXExtent * 2, (rect.fakeZExtent * 2) / Globals.zScale)
		draw_rect(rect2, Color(255, 0, 0), false, 1)
		"""

		var start = Vector2(self.getFakeXMin() - global_position.x, self.getFakeYMax() - self.fakeExtents.z * 2 - global_position.y)
		var stop = Vector2(self.getFakeXMin() - global_position.x, self.getFakeYMax() - global_position.y)
		draw_line(start, stop, Globals.BLUE, 1)

		start = Vector2(self.getFakeXMax() - global_position.x, self.getFakeYMax() - self.fakeExtents.z * 2 - global_position.y)
		stop = Vector2(self.getFakeXMax() - global_position.x, self.getFakeYMax() - global_position.y)
		draw_line(start, stop, Globals.BLUE, 1)

func slice2D(minVert : Vector2, maxVert : Vector2, xSlices : int, ySlices : int) -> Array: # Takes a 2D rectangle defined by minVert and maxVert, slices it xSlices and ySlices times on the respective axes at intervals proportional to total x and y grid sizes, and returns the array of vertices constituting the sliced rectangle
	var verts = []

	var gridSize = maxVert - minVert
	var xSliceInterval = gridSize.y / (xSlices + 2)
	var ySliceInterval = gridSize.x / (ySlices + 2)

	var curVert = minVert
	for i in (xSlices + 2):
		for j in (ySlices + 2):
			verts.append(Vector2(curVert.x, curVert.y))
			curVert.x += ySliceInterval
		curVert.x = minVert.x
		curVert.y += xSliceInterval

	return verts

func getLeftVerts(): # Returns the 4 vertices (as an array) that make up the left YZ plane
	"""
	var minVert2D = Vector2(fakePosition.y - fakeExtents.y, fakePosition.z - fakeExtents.z)
	var maxVert2D = Vector2(fakePosition.y + fakeExtents.y, fakePosition.z + fakeExtents.z)

	var verts2D : Array = slice2D(minVert2D, maxVert2D, int(collisionSlices.y), int(collisionSlices.z))
	
	var verts3D : Array = []
	for vert in verts2D:
		verts3D.append(Vector3(fakePosition.x - fakeExtents.x, vert.x, vert.y))

	var a = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, fakeExtents.z)

	verts3D += [a, b, c, d]

	return verts3D
	"""

	
	var a = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, fakeExtents.z)
	var e = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, 0)
	var f = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, 0)

	return [a, b, c, d, e, f]
	

	"""
	var a = Vector3(self.left.fakePosition.x, self.left.getFakeYMin(), self.left.getFakeZMin())
	var b = Vector3(self.left.fakePosition.x, self.left.getFakeYMin(), self.left.getFakeZMax())
	var c = Vector3(self.left.fakePosition.x, self.left.getFakeYMax(), self.left.getFakeZMin())
	var d = Vector3(self.left.fakePosition.x, self.left.getFakeYMax(), self.left.getFakeZMax())

	return [a, b, c, d]
	"""

func getRightVerts(): # Returns the 4 vertices (as an array) that make up the right YZ plane

	"""
	var minVert2D = Vector2(fakePosition.y - fakeExtents.y, fakePosition.z - fakeExtents.z)
	var maxVert2D = Vector2(fakePosition.y + fakeExtents.y, fakePosition.z + fakeExtents.z)

	var verts2D : Array = slice2D(minVert2D, maxVert2D, int(collisionSlices.y), int(collisionSlices.z))
	
	var verts3D : Array = []
	for vert in verts2D:
		verts3D.append(Vector3(fakePosition.x + fakeExtents.x, vert.x, vert.y))

	var a = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var d = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, fakeExtents.z)

	verts3D += [a, b, c, d]

	return verts3D
	"""
	
	
	var a = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var d = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, fakeExtents.z)
	var e = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, 0)
	var f = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, 0)

	return [a, b, c, d, e, f]
	

	"""
	var a = Vector3(self.right.fakePosition.x, self.right.getFakeYMin(), self.right.getFakeZMin())
	var b = Vector3(self.right.fakePosition.x, self.right.getFakeYMin(), self.right.getFakeZMax())
	var c = Vector3(self.right.fakePosition.x, self.right.getFakeYMax(), self.right.getFakeZMin())
	var d = Vector3(self.right.fakePosition.x, self.right.getFakeYMax(), self.right.getFakeZMax())

	return [a, b, c, d]
	"""

func getNorthVerts(): # Returns the 4 vertices (as an array) that make up the back XZ plane

	"""
	var minVert2D = Vector2(fakePosition.x - fakeExtents.x, fakePosition.z - fakeExtents.z)
	var maxVert2D = Vector2(fakePosition.x + fakeExtents.x, fakePosition.z + fakeExtents.z)

	var verts2D : Array = slice2D(minVert2D, maxVert2D, int(collisionSlices.x), int(collisionSlices.z))
	
	var verts3D : Array = []
	for vert in verts2D:
		verts3D.append(Vector3(vert.x, fakePosition.y - fakeExtents.y, vert.y))

	var a = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, -fakeExtents.z)

	verts3D += [a, b, c, d]

	return verts3D
	"""


	
	var a = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var e = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, 0)
	var f = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, 0)

	return [a, b, c, d, e, f]
	
	

	"""
	var a = Vector3(self.back.getFakeXMin(), self.back.fakePosition.y, self.back.getFakeZMin())
	var b = Vector3(self.back.getFakeXMin(), self.back.fakePosition.y, self.back.getFakeZMax())
	var c = Vector3(self.back.getFakeXMax(), self.back.fakePosition.y, self.back.getFakeZMin())
	var d = Vector3(self.back.getFakeXMax(), self.back.fakePosition.y, self.back.getFakeZMax())

	return [a, b, c, d]
	"""

func getSouthVerts(): # Returns the 4 vertices (as an array) that make up the front XZ plane

	"""
	var minVert2D = Vector2(fakePosition.x - fakeExtents.x, fakePosition.z - fakeExtents.z)
	var maxVert2D = Vector2(fakePosition.x + fakeExtents.x, fakePosition.z + fakeExtents.z)

	var verts2D : Array = slice2D(minVert2D, maxVert2D, int(collisionSlices.x), int(collisionSlices.z))
	
	var verts3D : Array = []
	for vert in verts2D:
		verts3D.append(Vector3(vert.x, fakePosition.y + fakeExtents.y, vert.y))

	var a = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, -fakeExtents.z)

	verts3D += [a, b, c, d]

	return verts3D
	"""
	
	
	var a = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var e = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, 0)
	var f = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, 0)

	return [a, b, c, d, e, f]
	
	

	"""
	var a = Vector3(self.front.getFakeXMin(), self.front.fakePosition.y, self.front.getFakeZMin())
	var b = Vector3(self.front.getFakeXMin(), self.front.fakePosition.y, self.front.getFakeZMax())
	var c = Vector3(self.front.getFakeXMax(), self.front.fakePosition.y, self.front.getFakeZMin())
	var d = Vector3(self.front.getFakeXMax(), self.front.fakePosition.y, self.front.getFakeZMax())

	return [a, b, c, d]
	"""

func getBottomVerts(): # Returns the 4 vertices (as an array) that make up the bottom XY plane
	
	"""
	var minVert2D = Vector2(fakePosition.x - fakeExtents.x, fakePosition.y - fakeExtents.y)
	var maxVert2D = Vector2(fakePosition.x + fakeExtents.x, fakePosition.y + fakeExtents.y)

	var verts2D : Array = slice2D(minVert2D, maxVert2D, int(collisionSlices.x), int(collisionSlices.y))
	
	var verts3D : Array = []
	for vert in verts2D:
		verts3D.append(Vector3(vert.x, vert.y, fakePosition.z - fakeExtents.z))

	var a = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, -fakeExtents.z)

	verts3D += [a, b, c, d]

	return verts3D
	"""

	
	var a = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, -fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, -fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, -fakeExtents.z)

	return [a, b, c, d]
	
	

	"""
	var a = Vector3(self.bottom.getFakeXMin(), self.bottom.getFakeYMin(), self.bottom.fakePosition.z)
	var b = Vector3(self.bottom.getFakeXMin(), self.bottom.getFakeYMax(), self.bottom.fakePosition.z)
	var c = Vector3(self.bottom.getFakeXMax(), self.bottom.getFakeYMin(), self.bottom.fakePosition.z)
	var d = Vector3(self.bottom.getFakeXMax(), self.bottom.getFakeYMax(), self.bottom.fakePosition.z)

	return [a, b, c, d]
	"""

func getTopVerts(): # Returns the 4 vertices (as an array) that make up the top XY plane

	"""
	var minVert2D = Vector2(fakePosition.x - fakeExtents.x, fakePosition.y - fakeExtents.y)
	var maxVert2D = Vector2(fakePosition.x + fakeExtents.x, fakePosition.y + fakeExtents.y)

	var verts2D : Array = slice2D(minVert2D, maxVert2D, int(collisionSlices.x), int(collisionSlices.y))
	
	var verts3D : Array = []
	for vert in verts2D:
		verts3D.append(Vector3(vert.x, vert.y, fakePosition.z + fakeExtents.z))

	var a = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, fakeExtents.z)

	verts3D += [a, b, c, d]

	return verts3D
	"""


	
	var a = fakePosition + Vector3(fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var b = fakePosition + Vector3(fakeExtents.x, -fakeExtents.y, fakeExtents.z)
	var c = fakePosition + Vector3(-fakeExtents.x, fakeExtents.y, fakeExtents.z)
	var d = fakePosition + Vector3(-fakeExtents.x, -fakeExtents.y, fakeExtents.z)

	return [a, b, c, d]
	
	

	"""
	var a = Vector3(self.top.getFakeXMin(), self.top.getFakeYMin(), self.top.fakePosition.z)
	var b = Vector3(self.top.getFakeXMin(), self.top.getFakeYMax(), self.top.fakePosition.z)
	var c = Vector3(self.top.getFakeXMax(), self.top.getFakeYMin(), self.top.fakePosition.z)
	var d = Vector3(self.top.getFakeXMax(), self.top.getFakeYMax(), self.top.fakePosition.z)

	return [a, b, c, d]
	"""

func getFakeXMin():
	return fakePosition.x - fakeExtents.x

func getFakeXMax():
	return fakePosition.x + fakeExtents.x

func getFakeYMin():
	return fakePosition.y - fakeExtents.y

func getFakeYMax():
	return fakePosition.y + fakeExtents.y

func getFakeZMin():
	return fakePosition.z - fakeExtents.z

func getFakeZMax():
	return fakePosition.z + fakeExtents.z