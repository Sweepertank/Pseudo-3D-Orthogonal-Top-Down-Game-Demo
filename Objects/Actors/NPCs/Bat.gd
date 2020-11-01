extends KinematicBody2D

var player = null
var dialogueBoxScene = preload("res://Objects/UI/DialogueBox.tscn")
var dialogueBox = null

func _ready():
	pass
	
func _process(delta):
	if player != null:
		if !player.inDialogueSession and Input.is_action_just_pressed("ui_interact"):
			#Begin dialogue session
			player.inDialogueSession = true
			player.frozen = true
			dialogueBox = dialogueBoxScene.instance()
			dialogueBox.player = player
			get_node("/root/World/GUI/Dialogue").add_child(dialogueBox)

func _on_TalkRadius_body_entered(body):
	if body.name == "Player":
		print("Player entered radius")
		player = body

func _on_TalkRadius_body_exited(body):
	if body.name == "Player":
		print("Player exited radius")
		player = null
