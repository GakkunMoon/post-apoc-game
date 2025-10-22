extends Sprite2D

@onready var roof: Sprite2D = $Roof
@onready var inside_modulate: CanvasModulate = $InsideBuilding
@onready var inside_light: PointLight2D = $PointLight2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	var tw = get_tree().create_tween().set_parallel()
	tw.tween_property(roof, "modulate", Color.TRANSPARENT, 1.0)
	tw.tween_property(inside_modulate, "color", Color.BLACK, 1.0)
	tw.tween_property(inside_light, "energy", 1.0, 0.5)

func _on_area_2d_body_exited(body: Node2D) -> void:
	var tw: Tween = create_tween().set_parallel()
	tw.tween_property(roof, "modulate", Color.WHITE, 1.0)
	tw.tween_property(inside_modulate, "color", Color.WHITE, 1.0)
	tw.tween_property(inside_light, "energy", 0.0, 1.0)
