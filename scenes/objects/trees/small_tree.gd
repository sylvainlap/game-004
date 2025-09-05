class_name SmallTree
extends Sprite2D

var log_scene = preload("res://scenes/objects/trees/log.tscn")

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent


func _ready() -> void:
	hurt_component.hurt.connect(_on_hurt)
	damage_component.max_damage_reached.connect(_on_max_damage_reached)


func add_log_scene() -> void:
	var log_instance = log_scene.instantiate() as Sprite2D
	log_instance.global_position = global_position
	get_parent().add_child(log_instance)


func _on_hurt(damage: int) -> void:
	damage_component.apply_damage(damage)
	material.set_shader_parameter("shake_intensity", 1.0)
	await get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)


func _on_max_damage_reached() -> void:
	call_deferred("add_log_scene")
	queue_free()
