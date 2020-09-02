extends Control

export (String) var title

func _ready():
	$Panel/Content/Labels/Title.text = title
	$Panel/Content/Interactive/HSlider.connect("changed", self, "_onSliderChange")

func _onSliderChange():
	$Panel/Content/Labels/Value.text = str($Panel/Content/Interactive/HSlider.value) + "%"
