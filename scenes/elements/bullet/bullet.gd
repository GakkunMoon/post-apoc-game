extends Sprite2D
class_name Bullet

var dir: Vector2 = Vector2.ZERO
var speed: float = 3500

func _process(delta: float) -> void:
	global_position += dir * speed  * delta
