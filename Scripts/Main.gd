# Node Tree:
#
# Node2D (Main)
#   ColorRect (Background)
#   Node2D (Objects)

extends Node2D

export (int) var numObjects

var objs = null
var rng = RandomNumberGenerator.new()
var objScene = preload("res://Scenes/Object.tscn")

func _ready():
	rng.randomize()
	
	#for _i in range(0, numObjects):
	#	var obj = objScene.instance()
	#	obj.mass = rng.randi_range(1, 999)
	#	
	#	obj.position = Vector2(rng.randf_range(0.0, 640.0), rng.randf_range(0.0, 480.0))
	#	$Objects.add_child(obj)
	
	objs = $Objects.get_children()

func _physics_process(delta):
	for o in objs:
		o.applyGravity(objs, delta)
