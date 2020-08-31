extends Control

onready var res = get_viewport().size

func _ready():
	$TopBar/Container/Menu.connect("toggled", self, "onMenuToggled")

func onMenuToggled(state):
	if state:
		$AnimationPlayer.play("menuOpen")
	else:
		$AnimationPlayer.play("menuClose")
	
	yield($AnimationPlayer, "animation_finished")
