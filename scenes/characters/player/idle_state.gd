extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(_delta: float) -> void:
	if player.facing_direction == Vector2.UP:
		animated_sprite_2d.play("idle_back")
	elif player.facing_direction == Vector2.DOWN:
		animated_sprite_2d.play("idle_front")
	elif player.facing_direction == Vector2.LEFT:
		animated_sprite_2d.play("idle_left")
	elif player.facing_direction == Vector2.RIGHT:
		animated_sprite_2d.play("idle_right")


func _on_next_transitions() -> void:
	GameInputEvents.movement_input()

	if GameInputEvents.is_movement_input():
		transition.emit("Walk")

	if player.current_tool == DataTypes.Tools.AXE_WOOD && GameInputEvents.use_tool():
		transition.emit("Chopping")

	if player.current_tool == DataTypes.Tools.TILL_GROUND && GameInputEvents.use_tool():
		transition.emit("Tilling")

	if player.current_tool == DataTypes.Tools.WATER_CROPS && GameInputEvents.use_tool():
		transition.emit("Watering")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
