extends Control

func _ready():
	$TopBar/Container/Reset.connect("toggled", self, "onMenuToggled")

func onMenuToggled(state):
	if state:
		$AnimationPlayer.play("menuOpen")
	else:
		$AnimationPlayer.play("menuClose")
	
	yield($AnimationPlayer, "animation_finished")
