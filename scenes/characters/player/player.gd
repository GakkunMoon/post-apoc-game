extends CharacterBody2D
class_name Player

@export var move_speed: float = 250

@onready var states: Node = $States
var current_state: PlayerState

var target_direction: Vector2 = Vector2.ZERO
var target_look_rotation: float

@onready var head_model: Sprite2D = $HumanModel/Head
@onready var torso_model: Node2D = $HumanModel/Torso
@onready var feet_anim: AnimationPlayer = $HumanModel/Feet/AnimationPlayer

func _input(event: InputEvent) -> void:
	target_direction = Input.get_vector("left", "right", "up", "down")

func _ready() -> void:
	change_state("Idle")

func _process(delta: float) -> void:
	if current_state:
		current_state.on_process(delta)
	
	var target_look_vector: Vector2 = (get_global_mouse_position() - global_position).normalized()
	target_look_rotation = atan2(target_look_vector.y, target_look_vector.x)
	head_model.rotation = lerp_angle(
		head_model.rotation,
		target_look_rotation + deg_to_rad(90),
		delta * 10)
	torso_model.rotation = lerp_angle(
		torso_model.rotation,
		target_look_rotation + deg_to_rad(90),
		delta * 5)
	
	if target_direction:
		feet_anim.play("walk")
		var target_move_rotation: float = atan2(target_direction.y, target_direction.x) + deg_to_rad(90)
		$HumanModel/Feet.rotation = lerp_angle(
			$HumanModel/Feet.rotation,
			target_move_rotation,
			delta * 5)
	else:
		feet_anim.play("idle")
		$HumanModel/Feet.rotation = lerp_angle(
			$HumanModel/Feet.rotation,
			target_look_rotation + deg_to_rad(90),
			delta * 3)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.on_physics_process(delta)
	
	velocity = target_direction * move_speed
	
	move_and_slide()

func change_state(new_state: String) -> void:
	if current_state:
		current_state.on_exit()
	var swap_state = states.get_node_or_null(new_state)
	if swap_state and swap_state is PlayerState:
		current_state = swap_state
		current_state.on_enter(self)
