extends Panel

var page = 0
var dialogue = ["Why hello there, master Pseudo-3D-Orthogonal-2D-Game-Demo! How do you fare on this fine afternoon?",
				"How do I do? Well, I'm glad you asked! I'm actually quite perfectly miserable, as a matter of fact.",
				"You see..."]
var player = null

onready var timer = $PrintTimer
onready var text = $Text

func _ready():
	text.set_bbcode(dialogue[page])
	text.set_visible_characters(0)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_interact"):
		if page < (dialogue.size()-1):
			page += 1
			text.set_bbcode(dialogue[page])
			text.set_visible_characters(0)
			timer.start()
		else:
			player.inDialogueSession = false
			player.frozen = false
			queue_free()

func _on_PrintTimer_timeout():
	if text.get_visible_characters() < text.get_total_character_count():
		text.set_visible_characters(text.get_visible_characters()+1)
	else:
		timer.stop()
