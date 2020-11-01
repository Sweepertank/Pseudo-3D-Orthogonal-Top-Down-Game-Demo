extends Node2D

onready var player = $FakeYSort/Player

func _process(delta):
	update()

func _draw():
	pass
	"""
	if Globals.drawRects or Globals.drawPlayerRects:
		var rect = player.volume.top
		var rect2 = Rect2(rect.getFakeXMin(), rect.getFakeYMin() - rect.fakePosition.z / Globals.zScale, rect.fakeXExtent * 2, rect.fakeYExtent * 2)
		draw_rect(rect2, Color(0, 255, 0), false, 1)

		rect = player.volume.bottom
		rect2 = Rect2(rect.getFakeXMin(), rect.getFakeYMin() - rect.fakePosition.z / Globals.zScale, rect.fakeXExtent * 2, rect.fakeYExtent * 2)
		draw_rect(rect2, Color(0, 255, 0), false, 1)

		rect = player.volume.front
		rect2 = Rect2(rect.getFakeXMin(), rect.fakePosition.y - (rect.fakeZExtent * 2 / Globals.zScale), rect.fakeXExtent * 2, (rect.fakeZExtent * 2) / Globals.zScale)
		draw_rect(rect2, Color(255, 0, 0), false, 1)

		rect = player.volume.back
		rect2 = Rect2(rect.getFakeXMin(), rect.fakePosition.y - (rect.fakeZExtent * 2 / Globals.zScale), rect.fakeXExtent * 2, (rect.fakeZExtent * 2) / Globals.zScale)
		draw_rect(rect2, Color(255, 0, 0), false, 1)

		rect = player.volume.left
		var start = Vector2(rect.fakePosition.x, rect.getFakeYMax() - (rect.fakeZExtent * 2 / Globals.zScale))
		var stop = Vector2(rect.fakePosition.x, rect.getFakeYMin() - (rect.fakeZExtent * 2 / Globals.zScale))
		draw_line(start, stop, Color(0, 0, 255), 1)

		rect = player.volume.right
		start = Vector2(rect.fakePosition.x, rect.getFakeYMax() - (rect.fakeZExtent * 2 / Globals.zScale))
		stop = Vector2(rect.fakePosition.x, rect.getFakeYMin() - (rect.fakeZExtent * 2 / Globals.zScale))
		draw_line(start, stop, Color(0, 0, 255), 1)
	"""
