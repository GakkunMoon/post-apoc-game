extends Node
class_name PlayerState

var _player: Player

func on_enter(player: Player) -> void:
	_player = player

func on_process(_delta: float) -> void:
	pass

func on_physics_process(_delta: float) -> void:
	pass

func on_exit() -> void:
	pass
