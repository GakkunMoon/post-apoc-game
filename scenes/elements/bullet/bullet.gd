extends Sprite2D
class_name Bullet

var damage: int = 1
var dir: Vector2 = Vector2.ZERO
var speed: float = 7000
@onready var raycast: RayCast2D = $RayCast2D

var impact_particles: PackedScene = preload("res://scenes/elements/bullet/impact_particles/impact_particles.tscn")

func _process(delta: float) -> void:
	global_position += dir * speed  * delta

func _physics_process(delta: float) -> void:
	if raycast.is_colliding():
		speed = 0
		global_position = raycast.get_collision_point()
		
		var particles: GPUParticles2D = impact_particles.instantiate()
		particles.emitting = true
		particles.global_position = raycast.get_collision_point()
		get_tree().root.add_child(particles)
		
		var body = raycast.get_collider()
		if body is HurtBox:
			body.take_damage(damage)
		queue_free()
