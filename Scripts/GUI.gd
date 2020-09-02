extends Control

signal zoomChanged(zoomAmount)
signal speedChanged(speedMod)

onready var res = get_viewport().size
var dialogOpened = false

var zoomAmount = 100
var speedMod = 100

func _ready():
	$TopBar/Container/Menu.connect("toggled", self, "onMenuToggled")
	$TopBar/Container/Zoom.connect("toggled", self, "onZoomToggled")
	$TopBar/Container/Speed.connect("toggled", self, "onSpeedToggled")
	
	$SliderDiag.connect("value_changed", self, "onSliderChanged")

func onMenuToggled(state):
	if state:
		closeSliderDiag()
		$AnimationPlayer.play("menuOpen")
	else:
		$AnimationPlayer.play("menuClose")
	yield($AnimationPlayer, "animation_finished")

func onZoomToggled(state):
	if state: 
		$SliderDiag.title = "Zoom"
		$SliderDiag.value = zoomAmount
		openSliderDiag()
	else: closeSliderDiag()

func onSpeedToggled(state):
	if state:
		$SliderDiag.title = "Speed"
		$SliderDiag.value = speedMod
		openSliderDiag()
	else: closeSliderDiag()

func onSliderChanged(val):
	match $SliderDiag.title:
		"Zoom":
			zoomAmount = val
			emit_signal("zoomChanged", val / 100.0)
		"Speed":
			speedMod = val
			emit_signal("speedChanged", val / 100.0)

func openSliderDiag():
	if dialogOpened:
		$AnimationPlayer.play("sliderDiagClose")
		yield($AnimationPlayer, "animation_finished")
	
	$SliderDiag.init()
	
	$AnimationPlayer.play("sliderDiagOpen")
	yield($AnimationPlayer, "animation_finished")
	
	dialogOpened = true

func closeSliderDiag():
	$AnimationPlayer.play("sliderDiagClose")
	yield($AnimationPlayer, "animation_finished")
	
	dialogOpened = false
