extends Node2D

const Player = preload("res://game/Player.tscn")
const Exit = preload("res://game/ExitArea.tscn")

var borders = Rect2(1, 1, 30, 17)

onready var tile_map = $TileMap


func _ready():
	randomize()
	generate_level()


func generate_level():
	var walker = Walker.new(Vector2(15, 8), borders)
	var map = walker.walk(200)
	
	var player = Player.instance()
	add_child(player)
	player.position = map.front() * 32
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = walker.get_end_room().position * 32
	exit.connect("leaving_level", self, "reload_level")

	walker.queue_free()
	for location in map:
		tile_map.set_cellv(location, -1)
	
	tile_map.update_bitmask_region(borders.position, borders.end)


func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().reload_current_scene()


func reload_level():
	get_tree().reload_current_scene()
