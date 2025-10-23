class_name PlayerAttack
extends BaseState

var player: Node
var sprite: AnimatedSprite2D
var ATTACK_TIME: float = 0.6
var t: float = 0.0

func set_player(p: Node) -> void:
	player = p
	sprite = player.get_sprite()

func enter() -> void:
	if sprite == null:
		sprite = player.get_sprite()
	t = ATTACK_TIME
	if sprite:
		sprite.play("attack")
		print("[Attack] play attack")  # LOG


func handle_inputs(event: InputEvent) -> void: pass
func update(delta: float) -> void: pass

func physics_update(delta: float) -> void:
	var a := Input.is_action_just_pressed("attack")
	# print("[Attack] pressed? ", a)   # décommente 1 seconde si besoin
	player.velocity.x = move_toward(player.velocity.x, 0.0, player.ACCEL)

	t -= delta
	if t <= 0.0:
		var dir: float = Input.get_axis("ui_left", "ui_right")
		Transitioned.emit(self, "PlayerRun" if dir != 0.0 else "PlayerIdle")

func exit() -> void: pass
