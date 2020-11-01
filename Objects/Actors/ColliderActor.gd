extends Actor
class_name ColliderActor

var collider : Collider
export var fakeExtents : Vector3

func _ready():
	initFakePosition()

	var collisionSlices = Vector3(1, 1, 1)
	collider = BoxCollider.new(fakePosition, fakeExtents, collisionSlices, self)
	add_child(collider)

func initFakePosition():
	fakePosition = Vector3(position.x, position.y + zStart + fakeExtents.z, zStart + fakeExtents.z)

func setFakePosition(_position: Vector3):
	fakePosition = _position
	collider.setFakePosition(_position)

func setFakeX(x):
	collider.setFakeX(x)
	fakePosition.x = x

func setFakeY(y):
	collider.setFakeY(y)
	fakePosition.y = y

func setFakeZ(z):
	collider.setFakeZ(z)
	fakePosition.z = z

func getFakeXMin():
	return collider.getFakeXMin()

func getFakeXMax():
	return collider.getFakeXMax()

func getFakeYMin():
	return collider.getFakeYMin()

func getFakeYMax():
	return collider.getFakeYMax()

func getFakeZMin():
	return collider.getFakeZMin()

func getFakeZMax():
	return collider.getFakeZMax()

func getSortY():
	return getFakeYMax()