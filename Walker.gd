extends Node
class_name Walker

const DIRECTIONS = [Vector2.UP, Vector2.DOWN, Vector2.LEFT, Vector2.RIGHT]

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history = []
var step_since_turn = 0


func _init(start_position, new_borders):
	assert(new_borders.has_point(start_position))
	position = start_position
	step_history.append(position)
	borders = new_borders


func walk(steps):
	for step in steps:
		if randf() <= 0.25 or step_since_turn >= 4:
			change_direction()
		
		if step():
			step_history.append(position)
		else:
			change_direction()
		
	return step_history


func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		step_since_turn += 1
		position = target_position
		return true
	else:
		return false


func change_direction():
	step_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()


