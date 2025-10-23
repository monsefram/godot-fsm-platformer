class_name PlayerRun
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
		sprite.play("run")
		print("[Run] play run")  # LOG

func physics_update(delta: float) -> void:
	var dir: float = Input.get_axis("ui_left", "ui_right")

	# SAUT
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		player.velocity.y = -player.JUMP_FORCE

	# accélération / ralentissement
	if dir != 0.0:
		var target: float = player.MAX_SPEED * dir
		player.velocity.x = lerp(player.velocity.x, target, (player.ACCEL * 1.0) / player.MAX_SPEED)
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.2)

	if dir != 0.0 and sprite:
		sprite.flip_h = (dir < 0.0)

	# transitions
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "PlayerAttack")
	elif dir == 0.0:
		Transitioned.emit(self, "PlayerIdle")

func handle_inputs(event: InputEvent) -> void: pass
func update(delta: float) -> void: pass
