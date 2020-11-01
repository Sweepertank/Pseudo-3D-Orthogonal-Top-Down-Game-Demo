extends Node2D

var dynamics : Array = []

class NodeToSort:
	var node : Node
	var yGetter : FuncRef

	func _init(_node : Node, _fakeYGetter : FuncRef):
		self.node = _node
		self.fakeYGetter = _fakeYGetter

	func getFakeY():
		return self.fakeYGetter.call_func()

func _ready():
	for node in getChildrenRecursive(self):
		if node is Actor:
			node.set_z_index(node.getSortY())
		if node is DynamicActor:
			dynamics.append(node)

func getChildrenRecursive(node):
	var children = node.get_children()
	for child in node.get_children():
		children += getChildrenRecursive(child)
	return children

func _process(delta):
	sortDynamics()

func sortDynamics():
	for node in dynamics:
		node.set_z_index(node.getSortY())
