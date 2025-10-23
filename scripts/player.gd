extends CharacterBody2D
class_name Player

# Mouvements
const MAX_SPEED := 300.0
const ACCEL := 300.0
const JUMP_FORCE := 400.0   
var GRAVITY := ProjectSettings.get_setting("physics/2d/default_gravity") as float  # PAS un const

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func get_sprite() -> AnimatedSprite2D:
	return sprite

func has_anim(name: String) -> bool:
	return sprite and sprite.sprite_frames and sprite.sprite_frames.has_animation(name)

func play_best(names: Array[String]) -> void:
	if not sprite or not sprite.sprite_frames:
		return
	for n in names:
		if sprite.sprite_frames.has_animation(n):
			sprite.play(n)
			return
	# si aucune ne matche, on garde l'anim en cours

func _physics_process(delta: float) -> void:
	# simple gravité (même si tu n'as pas de saut, utile sur pentes)
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	move_and_slide()
