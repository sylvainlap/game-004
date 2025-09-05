class_name Rock
extends Sprite2D

var stone_scene = preload("res://scenes/objects/rocks/stone.tscn")

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent


func _ready() -> void:
	hurt_component.hurt.connect(_on_hurt)
	damage_component.max_damage_reached.connect(_on_max_damage_reached)


func add_stone_scene() -> void:
	var stone_instance = stone_scene.instantiate() as Sprite2D
	stone_instance.global_position = global_position
	get_parent().add_child(stone_instance)


func _on_hurt(damage: int) -> void:
	damage_component.apply_damage(damage)
	material.set_shader_parameter("shake_intensity", 1.0)
	await get_tree().create_timer(0.5).timeout
	material.set_shader_parameter("shake_intensity", 0.0)


func _on_max_damage_reached() -> void:
	call_deferred("add_stone_scene")
	queue_free()
