class_name InteractableComponent
extends Area2D

signal interactable_activated
signal interactable_deactivated


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(_body: Node) -> void:
	interactable_activated.emit()


func _on_body_exited(_body: Node) -> void:
	interactable_deactivated.emit()
