extends ColliderActor
class_name DynamicActor

var velocity : Vector3 = Vector3()
var moveForce : Vector3 = Vector3()
var camera = null #Only applies to player; has to be declared here for workaround hack involving not being able to override _process functions

func _process(delta):
	updateRealPosition()
	if camera != null: #basically, base class _processes are always called after those of subclasses, but we need to align the player's camera AFTER this function runs or we get slight misalignment
		camera.align()
