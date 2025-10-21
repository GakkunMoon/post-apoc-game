extends Node2D
class_name HumanModel

@onready var head: Node2D = $Head
@onready var torso: Node2D = $Torso
@onready var feet: Node2D = $Feet
@onready var arms_anim: AnimationPlayer = $Torso/IKTargets/AnimationPlayer
@onready var feet_anim: AnimationPlayer = $Feet/AnimationPlayer
@onready var flash: PointLight2D = $Torso/IKTargets/Flash

var bullet: PackedScene = preload("res://scenes/elements/bullet/bullet.tscn")

var r: bool = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("reload"):
		r = not r
		if r:
			arms_anim.play("rifle")
		else:
			arms_anim.play("pistol")

func fire_gun() -> void:
	flash.enabled = true
	var t: Timer = flash.get_child(0)
	t.start()
	
	var b: Bullet = bullet.instantiate()
	b.global_position = flash.global_position
	b.dir = Vector2.UP.rotated(torso.rotation)
	b.rotation = torso.rotation
	get_tree().root.add_child(b)
	
	await t.timeout
	flash.enabled = false
