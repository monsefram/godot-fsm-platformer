extends Node

@export var initial_state: Node   # on peut le laisser vide : fallback -> PlayerIdle
var current_state: Node
var states: Dictionary = {}

func _ready() -> void:
	# 1) indexer les états
	for child in get_children():
		if child is BaseState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(_on_child_transition)

	# 2) auto-câbler le Player (parent de la StateMachine)
	var player: Node = get_parent()  # <-- typé explicitement
	for s: Node in states.values():
		if s is BaseState:
			(s as BaseState).set_player(player)

	# 3) état initial (fallback = PlayerIdle)
	if initial_state == null:
		var fallback: Node = states.get("playeridle")
		if fallback:
			initial_state = fallback

	if initial_state and initial_state is BaseState:
		current_state = initial_state
		(current_state as BaseState).enter()

func _process(delta: float) -> void:
	if current_state and current_state is BaseState:
		(current_state as BaseState).update(delta)

func _physics_process(delta: float) -> void:
	if current_state and current_state is BaseState:
		(current_state as BaseState).physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_state and current_state is BaseState:
		(current_state as BaseState).handle_inputs(event)

func _on_child_transition(state, new_state_name: String) -> void:
	if state != current_state:
		return
	print("[FSM] transition ", state.name, " -> ", new_state_name)  # << LOG
	var new_state: Node = states.get(new_state_name.to_lower())
	if new_state == null:
		push_warning("StateMachine: état '%s' introuvable." % new_state_name)
		return
	if current_state and current_state is BaseState:
		print("[FSM] exit ", current_state.name)  # << LOG
		(current_state as BaseState).exit()
	current_state = new_state
	if current_state is BaseState:
		print("[FSM] enter ", current_state.name)  # << LOG
		(current_state as BaseState).enter()
