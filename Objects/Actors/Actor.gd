extends Node2D
class_name Actor

var fakePosition : Vector3 setget setFakePosition, getFakePosition
export var zStart : int = 0
export var sortYOffset = 0

func initFakePosition():
	fakePosition = Vector3(position.x, position.y + zStart, zStart)

func updateRealPosition():
	position.x = fakePosition.x
	position.y = fakePosition.y - fakePosition.z

func setFakePosition(_position : Vector3):
	fakePosition = _position

func getFakePosition():
	return fakePosition

func getFakeX():
	return fakePosition.x

func setFakeX(x):
	fakePosition.x = x

func getFakeY():
	return fakePosition.y

func setFakeY(y):
	fakePosition.y = y

func getFakeZ():
	return fakePosition.z

func setFakeZ(z):
	fakePosition.z = z

func getFakeXMin():
	return fakePosition.x

func getFakeXMax():
	return fakePosition.x

func getFakeYMin():
	return fakePosition.y

func getFakeYMax():
	return fakePosition.y

func getFakeZMin():
	return fakePosition.z

func getFakeZMax():
	return fakePosition.z

func getSortY():
	return fakePosition.y + sortYOffset
