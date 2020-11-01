extends DynamicActor
class_name PhysicsActor

export var gravity : float
var fallSpeed : float = 0
var fallSpeedCap : float = -10
var inAir : bool = true
var impulse : Vector3 = Vector3()

func _process(delta):
	
	fallSpeed += gravity * delta + impulse.z

	if fallSpeed < fallSpeedCap:
		fallSpeed = fallSpeedCap
	
	#Z
	velocity.z = fallSpeed + moveForce.z
	if velocity.z < 0:
		var projectedZ = collider.getFakeZMin() + velocity.z
		for vert in collider.getBottomVerts():
			var collisions = RectWorld.getXYRectsIntersectedBy(int(vert.x), int(vert.y), int(ceil(vert.z)), projectedZ)
			for tile in collisions:
				inAir = false
				fallSpeed = 0
				velocity.z = 0
				if tile.fakePosition.z > projectedZ:
					projectedZ = tile.fakePosition.z
		setFakeZ(projectedZ + collider.fakeExtents.z)
		#setFakePosition(Vector3(fakePosition.x, fakePosition.y, projectedZ + collider.fakeExtents.z))
	else:
		setFakeZ(fakePosition.z + velocity.z)
		#setFakePosition(Vector3(fakePosition.x, fakePosition.y, fakePosition.z + velocity.z))
		inAir = true
	#collider.updateFakePosition()

	#X
	velocity.x = moveForce.x
	if velocity.x > 0:
		var projectedX = collider.getFakeXMax() + velocity.x
		for vert in collider.getRightVerts():
			var collisions = RectWorld.getYZRectsIntersectedBy(int(vert.y), int(vert.z), int(vert.x), projectedX)
			for tile in collisions:
				velocity.x = 0
				if tile.fakePosition.x < projectedX:
					projectedX = tile.fakePosition.x
		setFakeX(projectedX - collider.fakeExtents.x)
		#setFakePosition(Vector3(projectedX - collider.fakeExtents.x, fakePosition.y, fakePosition.z))
	else:
		var projectedX = collider.getFakeXMin() + velocity.x
		for vert in collider.getLeftVerts():
			var collisions = RectWorld.getYZRectsIntersectedBy(int(vert.y), int(vert.z), int(vert.x), projectedX)
			for tile in collisions:
				velocity.x = 0
				if tile.fakePosition.x > projectedX:
					projectedX = tile.fakePosition.x
		setFakeX(projectedX + collider.fakeExtents.x)
		#setFakePosition(Vector3(projectedX + collider.fakeExtents.x, fakePosition.y, fakePosition.z))
	#collider.updateFakePosition()

	#Y
	velocity.y = moveForce.y
	if velocity.y > 0:
		var projectedY = collider.getFakeYMax() + velocity.y
		for vert in collider.getSouthVerts():
			var collisions = RectWorld.getXZRectsIntersectedBy(int(vert.x), int(vert.z), int(vert.y), projectedY)
			for tile in collisions:
				velocity.y = 0
				if tile.fakePosition.y < projectedY:
					projectedY = tile.fakePosition.y
		setFakeY(projectedY - collider.fakeExtents.y)
		#setFakePosition(Vector3(fakePosition.x, projectedY - collider.fakeExtents.y, fakePosition.z))
	else:
		var projectedY = collider.getFakeYMin() + velocity.y
		for vert in collider.getNorthVerts():
			var collisions = RectWorld.getXZRectsIntersectedBy(int(vert.x), int(vert.z), int(vert.y), projectedY)
			for tile in collisions:
				velocity.y = 0
				if tile.fakePosition.y > projectedY:
					projectedY = tile.fakePosition.y
		setFakeY(projectedY + collider.fakeExtents.y)
		#setFakePosition(Vector3(fakePosition.x, projectedY + collider.fakeExtents.y, fakePosition.z))
	#collider.updateFakePosition()
	
	"""
	fallSpeed += gravity * delta + impulse.z

	if fallSpeed < fallSpeedCap:
		fallSpeed = fallSpeedCap
	
	#Z
	velocity.z = fallSpeed + moveForce.z
	if velocity.z < 0:
		var projectedZ = collider.getBboxZMin() + velocity.z
		for vert in collider.getBboxZBottomVerts():
			var collisions = RectWorld.getXYRectsIntersectedBy(int(vert.x), int(vert.y), int(vert.z), projectedZ)
			for tile in collisions:
				inAir = false
				velocity.z = 0
				fallSpeed = 0
				if tile.fakePosition.z > projectedZ:
					projectedZ = tile.fakePosition.z
		setFakeZ(projectedZ + collider.fakeExtents.z)
	else:
		setFakeZ(fakePosition.z + velocity.z)
		inAir = true
	collider.updateFakePosition()

	#X
	velocity.x = moveForce.x
	if velocity.x > 0:
		var projectedX = collider.getBboxXMax() + velocity.x
		for vert in collider.getBboxXRightVerts():
			var collisions = RectWorld.getYZRectsIntersectedBy(int(vert.y), int(vert.z), int(vert.x), projectedX)
			for tile in collisions:
				velocity.x = 0
				if tile.fakePosition.x < projectedX:
					projectedX = tile.fakePosition.x
		setFakeX(projectedX - collider.fakeExtents.x)
	else:
		var projectedX = collider.getBboxXMin() + velocity.x
		for vert in collider.getBboxXLeftVerts():
			var collisions = RectWorld.getYZRectsIntersectedBy(int(vert.y), int(vert.z), int(vert.x), projectedX)
			for tile in collisions:
				velocity.x = 0
				if tile.fakePosition.x > projectedX:
					projectedX = tile.fakePosition.x
		setFakeX(projectedX + collider.fakeExtents.x)
	collider.updateFakePosition()

	#Y
	velocity.y = moveForce.y
	if velocity.y < 0:
		var h = 5
	if velocity.y > 0:
		var projectedY = collider.getBboxYMax() + velocity.y
		for vert in collider.getBboxYSouthVerts():
			var collisions = RectWorld.getXZRectsIntersectedBy(int(vert.x), int(vert.z), int(vert.y), projectedY)
			for tile in collisions:
				velocity.y = 0
				if tile.fakePosition.y < projectedY:
					projectedY = tile.fakePosition.y
		setFakeY(projectedY - collider.fakeExtents.y)
	else:
		var projectedY = collider.getBboxYMin() + velocity.y
		for vert in collider.getBboxYNorthVerts():
			var collisions = RectWorld.getXZRectsIntersectedBy(int(vert.x), int(vert.z), int(vert.y), projectedY)
			for tile in collisions:
				velocity.y = 0
				if tile.fakePosition.y > projectedY:
					projectedY = tile.fakePosition.y
		setFakeY(projectedY + collider.fakeExtents.y)
	collider.updateFakePosition()
	"""
