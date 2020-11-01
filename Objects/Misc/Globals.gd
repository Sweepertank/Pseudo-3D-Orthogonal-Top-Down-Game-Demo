extends Node

var drawRects = false
var drawVolumes = false

enum LEVELS {OUTSIDE_1, OUTSIDE_2, OUTSIDE_3}
const levelPaths = {LEVELS.OUTSIDE_1 : "res://Levels/Outside.tscn",
					LEVELS.OUTSIDE_2 : "res://Levels/Outside2.tscn",
					LEVELS.OUTSIDE_3 : "res://Levels/Outside3.tscn"}

const RED = Color(255, 0, 0)
const GREEN = Color(0, 255, 0)
const BLUE = Color(0, 0, 255)

const zScale = 1

enum BIOME {NONE}
