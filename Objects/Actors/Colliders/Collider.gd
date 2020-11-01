extends Actor
class_name Collider

var planes : Array
var fakeExtents : Vector3

func _init(_fakePosition : Vector3, _fakeExtents : Vector3):
	fakePosition = _fakePosition
	fakeExtents = _fakeExtents

func setFakePosition(position : Vector3):
	var transform = position - fakePosition
	for plane in planes:
		plane.fakePosition += transform
	fakePosition += transform

func setFakeX(x):
	var transform = x - fakePosition.x
	for plane in planes:
		plane.fakePosition.x += transform
	fakePosition.x = x

func setFakeY(y):
	var transform = y - fakePosition.y
	for plane in planes:
		plane.fakePosition.y += transform
	fakePosition.y = y

func setFakeZ(z):
	var transform = z - fakePosition.z
	for plane in planes:
		plane.fakePosition.z += transform
	fakePosition.z = z

func getFakeXMin() -> float:
	var _min = fakePosition.x
	for plane in planes:
		if plane.getFakeXMin() < _min:
			_min = plane.getFakeXMin()
	return _min

func getFakeXMax() -> float:
	var _max = fakePosition.x
	for plane in planes:
		if plane.getFakeXMax() > _max:
			_max = plane.getFakeXMax()
	return _max

func getFakeYMin() -> float:
	var _min = fakePosition.y
	for plane in planes:
		if plane.getFakeYMin() < _min:
			_min = plane.getFakeYMin()
	return _min

func getFakeYMax() -> float:
	var _max = fakePosition.y
	for plane in planes:
		if plane.getFakeYMax() > _max:
			_max = plane.getFakeYMax()
	return _max

func getFakeZMin() -> float:
	var _min = fakePosition.z
	for plane in planes:
		if plane.getFakeZMin() < _min:
			_min = plane.getFakeZMin()
	return _min

func getFakeZMax() -> float:
	var _max = fakePosition.z
	for plane in planes:
		if plane.getFakeZMax() > _max:
			_max = plane.getFakeZMax()
	return _max