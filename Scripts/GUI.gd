extends Control

onready var res = get_viewport().size
var dialogOpened = false

func _ready():
	$TopBar/Container/Menu.connect("toggled", self, "onMenuToggled")
	$TopBar/Container/Zoom.connect("toggled", self, "onZoomToggled")
	$TopBar/Container/Speed.connect("toggled", self, "onSpeedToggled")

func onMenuToggled(state):
	if state:
		if dialogOpened: hideDiags()
		$AnimationPlayer.play("menuOpen")
	else:
		$AnimationPlayer.play("menuClose")
	
	yield($AnimationPlayer, "animation_finished")

func onZoomToggled(state):
	if dialogOpened: hideDiags()
	
	if state: $Dialogs/ZoomSlider.show()
	else: $Dialogs/ZoomSlider.hide()
	
	dialogOpened = state

func onSpeedToggled(state):
	if dialogOpened: hideDiags()
	
	if state: $Dialogs/SpeedSlider.show()
	else: $Dialogs/SpeedSlider.hide()
	
	dialogOpened = state

func hideDiags():
	for d in $Dialogs.get_children():
		d.hide()
	
	for b in $TopBar/Container.get_children():
		if b == $TopBar/Container/Menu: continue
		if b.pressed: b.pressed = false
