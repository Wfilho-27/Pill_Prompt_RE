extends CanvasLayer

onready var animation = get_node("Animation")
var target_level: String

func fade_in(level: String) -> void:
	target_level = level
	animation.play("fade_in")



func on_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		var _change_scene = get_tree().change_scene(target_level)
		animation.play("fade_out")

func fad_in() -> void:
	animation.play("fade_in")

func fad_out() -> void:
	animation.play("fade_out")

