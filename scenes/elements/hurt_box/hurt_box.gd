extends Area2D
class_name HurtBox

var attached_entity

func take_damage(dmg: int) -> void:
	if get_parent().has_method("take_damage"):
		get_parent().take_damage(dmg)
