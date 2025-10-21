extends CharacterBody2D
class_name Player

@export var move_speed: float = 250

@onready var states: Node = $States
var current_state: PlayerState

var target_direction: Vector2 = Vector2.ZERO
var target_look_rotation: float

@onready var human_model: HumanModel = $HumanModel
@onready var camera: Camera2D = $Camera/Camera2D

func _input(event: InputEvent) -> void:
	target_direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("shoot"):
		human_model.fire_gun()

func _ready() -> void:
	change_state("Idle")

func _process(delta: float) -> void:
	if current_state:
		current_state.on_process(delta)
	
	var target_look_vector: Vector2 = (get_global_mouse_position() - global_position).normalized()
	target_look_rotation = atan2(target_look_vector.y, target_look_vector.x)
	human_model.head.rotation = lerp_angle(
		human_model.head.rotation,
		target_look_rotation + deg_to_rad(90),
		delta * 10
	)
	human_model.torso.rotation = lerp_angle(
		human_model.torso.rotation,
		target_look_rotation + deg_to_rad(90),
		delta * 5
	)
	
	if target_direction:
		human_model.feet_anim.play("walk")
		var target_move_rotation: float = atan2(target_direction.y, target_direction.x) + deg_to_rad(90)
		human_model.feet.rotation = lerp_angle(
			human_model.feet.rotation,
			target_move_rotation,
			delta * 5
		)
	else:
		human_model.feet_anim.play("idle")
		human_model.feet.rotation = lerp_angle(
			human_model.feet.rotation,
			target_look_rotation + deg_to_rad(90),
			delta * 3
		)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.on_physics_process(delta)
	
	velocity = target_direction * move_speed
	
	var camera_pos: Vector2 = Vector2(
		(get_global_mouse_position().x + global_position.x) / 2,
		(get_global_mouse_position().y + global_position.y) / 2
	)
	camera.global_position = lerp(camera.global_position, camera_pos, delta)
	
	move_and_slide()

func change_state(new_state: String) -> void:
	if current_state:
		current_state.on_exit()
	var swap_state = states.get_node_or_null(new_state)
	if swap_state and swap_state is PlayerState:
		current_state = swap_state
		current_state.on_enter(self)
