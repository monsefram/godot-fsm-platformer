class_name BaseState
extends Node

# Signal pour annoncer un changement d’état
signal Transitioned

func handle_inputs(input_event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func set_player(p: Node) -> void:
	# overridé dans les états
	pass
