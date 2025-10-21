@tool
extends EditorScript


# Called when the script is executed (using File -> Run in Script Editor).
func _run() -> void:
	print(actividad_1_2d(Vector2(3, 5), Vector2(1, 3)))

func actividad_1_2d(v1: Vector2, v2: Vector2) -> Vector2:
	var punto_medio: Vector2 = (v1 + v2) / 2
	return punto_medio

func actividad_1_3d(v1: Vector3, v2: Vector3) -> Vector3:
	var punto_medio: Vector3 = (v1 + v2) / 2
	return punto_medio

func actividad_2() -> void:
	pass
