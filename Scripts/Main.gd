# Node Tree:
#
# Control (Main)
#   ColorRect (Background)
#   Node2D (Objects)

extends Control

export (int) var numObjects

var objs = null
var rng = RandomNumberGenerator.new()
var objScene = preload("res://Scenes/Object.tscn")

onready var res = Vector2(1080, 1920)

func _ready():
	rng.randomize()
	
	for _i in range(0, numObjects):
		var obj = objScene.instance()
		obj.mass = rng.randi_range(1, 9999)
		
	#	obj.dir = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1))
	#	obj.speed = rng.randi_range(0, 100)
		
		obj.position = Vector2(rng.randf_range(0.0, res.x), rng.randf_range(0.0, res.y))
		$Objects.add_child(obj)

func _physics_process(delta):
	objs = $Objects.get_children()
	
	for o in objs:
		o.applyGravity(objs, delta)
