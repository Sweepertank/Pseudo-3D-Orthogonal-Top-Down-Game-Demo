extends PhysicsActor
class_name Character

export var moveSpeed : Vector3
export var jumpImpulse : float
var jumping : bool = false
onready var animationTree : AnimationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _process(delta):
	animation()

func animation():
	if inAir:
		pass
	elif Vector2(moveForce.x, moveForce.y):
		animationTree.set("parameters/Idle/blend_position", Vector2(moveForce.x, moveForce.y))
		animationTree.set("parameters/Run/blend_position", Vector2(moveForce.x, moveForce.y))
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
