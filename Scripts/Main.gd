# Node Tree:
#
# Node2D (Main)
#   ColorRect (Background)
#   Node2D (Objects)

extends Node2D

onready var objs = $Objects.get_children()

func _ready():
	pass

func _physics_process(delta):
	for o in objs:
		o.applyGravity(objs, delta)
