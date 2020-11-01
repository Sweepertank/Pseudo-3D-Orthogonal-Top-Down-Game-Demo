extends Character

var input : Vector2 = Vector2()
var inDialogueSession : bool = false
var frozen : bool = false
var levitating = false
onready var jumpSound = $AudioStreamPlayer2D

func _ready():
	camera = $Camera2D
	
	#camera.set_limit(MARGIN_LEFT , 0)
	#camera.set_limit(MARGIN_RIGHT, 640)
	#camera.set_limit(MARGIN_TOP, 0)
	#camera.set_limit(MARGIN_BOTTOM, 384)
	var border = get_tree().get_nodes_in_group("BorderTileMap3D")
	var rect = border[0].rect
	
	camera.set_limit(MARGIN_LEFT , rect.position.x * border[0].cell_size.x)
	camera.set_limit(MARGIN_RIGHT, rect.end.x * border[0].cell_size.x)
	camera.set_limit(MARGIN_TOP, rect.position.y * border[0].cell_size.y)
	camera.set_limit(MARGIN_BOTTOM, rect.end.y * border[0].cell_size.y)

func _process(delta):
	getInput()
	moveForce.x = input.x * moveSpeed.x * delta
	moveForce.y = input.y * moveSpeed.y * delta
	moveForce.z = int(levitating) * delta
	impulse.z = int(not inAir) * int(jumping) * jumpImpulse
	
	if jumping and (not inAir):
		jumpSound.play(0)

	#updateRealPosition()
	#volume.setFakePosition(fakePosition)

	#volume.update()
	#volume._draw()

func getInput():
	var h = Input.is_action_pressed("ui_right")
	var l = Input.is_action_pressed("ui_left")
	
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	input = input.normalized()

	levitating = Input.is_action_pressed("ui_levitate")

	jumping = Input.is_action_just_pressed("ui_jump")
