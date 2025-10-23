class_name PlayerIdle
extends BaseState

var player: Node
var sprite: AnimatedSprite2D

func set_player(p: Node) -> void:
	player = p
	sprite = player.get_sprite()

func enter() -> void:
	if sprite == null:
		sprite = player.get_sprite()
	if sprite:
		sprite.play("idle")
		print("[Idle] play idle")  # LOG

func physics_update(delta: float) -> void:
	var dir: float = Input.get_axis("ui_left", "ui_right")

	if dir != 0.0 and sprite:
		sprite.flip_h = (dir < 0.0)

	# SAUT
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = -player.JUMP_FORCE

	player.velocity.x = move_toward(player.velocity.x, 0.0, player.ACCEL)

	# transitions
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "PlayerAttack")
	elif dir != 0.0:
		Transitioned.emit(self, "PlayerRun")

func handle_inputs(event: InputEvent) -> void: pass
func update(delta: float) -> void: pass
