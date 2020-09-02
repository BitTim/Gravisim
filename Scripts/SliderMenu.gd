extends Control

export (String) var title
export (float) var value

signal value_changed(value)

func _ready():
	init()
	$Panel/Content/Interactive/HSlider.connect("value_changed", self, "_onSliderChange")

func init():
	$Panel/Content/Labels/Title.text = title
	$Panel/Content/Interactive/HSlider.value = value

func _onSliderChange(val):
	$Panel/Content/Labels/Value.text = str(val) + "%"
	emit_signal("value_changed", val)
