extends GridContainer

var heldItem = null
var slotClass = load("res://Objects/UI/PlayerHUD/Hotbar/Slot.gd")

onready var heldItemSprite : Sprite = $HeldItemSprite
onready var selectionMarker : Panel = $SelectionMarker
var selectedSlot : Panel

func _ready():
	for slot in get_children():
		if slot is slotClass:
			slot.connect("gui_input", self, "onSlotReceivedInput", [slot])

	setSelectedSlot($Slot1)

func setSelectedSlot(slot : Panel):
	if has_node("SelectionMarker"):
		remove_child(selectionMarker)
		selectionMarker.visible = true
	else:
		selectedSlot.remove_child(selectionMarker)

	slot.add_child(selectionMarker)
	selectionMarker.rect_position = Vector2()

	selectedSlot = slot

func onSlotReceivedInput(event : InputEvent, slot):
	if Input.is_action_just_pressed("leftClick"):
		if heldItem:
			if slot.item:
				var temp = slot.item
				slot.setItem(heldItem)
				setHeldItem(temp)
			else:
				slot.setItem(heldItem)
				setSelectedSlot(slot)
				clearHeldItem()
		else:
			if slot == selectedSlot:
				if slot.item:
					setHeldItem(slot.item)
					slot.clearItem()
			else:
				setSelectedSlot(slot)

func clearHeldItem():
	heldItem = null
	heldItemSprite.texture = null

func setHeldItem(_item):
	heldItem = _item
	heldItemSprite.texture = _item.texture

func _process(delta):
	if heldItem:
		heldItemSprite.position = get_local_mouse_position()


