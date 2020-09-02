# Node Tree:
#
# KinematicBody2D (Object)
#   CollisionShape2D (CollisionShape2D)

extends KinematicBody2D

export (int) var mass
export (bool) var immovable = false
export (Vector2) var dir
export (int) var speed

const G = 6674
const LPT = 2048

var radius
var vel = Vector2()
var accel = Vector2()

var col = Color()

var rng = RandomNumberGenerator.new()
onready var res = Vector2(1080, 1920)

# ================================
# Utility
# ================================

func _ready():
	rng.randomize()
	vel = dir * speed
	
	col = Color(rng.randf_range(0.5, 1), rng.randf_range(0.5, 1), rng.randf_range(0.5, 1), 1)
	$CanvasLayer/Line2D.default_color= col
	
	updateValues(mass)

func _draw():
	draw_circle(Vector2(), radius, col)

func getRadius():
	return round(sqrt(mass / 10.0))

func updateValues(mass):
	self.mass = mass
	radius = getRadius()
	
	var shape = CircleShape2D.new()
	shape.set_radius(radius)
	$CollisionShape2D.shape = shape
	
	update()

func updateLine():
	if $CanvasLayer/Line2D.get_point_count() > LPT:
		$CanvasLayer/Line2D.remove_point(0);
	
	if $CanvasLayer/Line2D.get_point_count() > 0:
		if $CanvasLayer/Line2D.get_point_position($CanvasLayer/Line2D.get_point_count() - 1) != global_position:
			$CanvasLayer/Line2D.add_point(global_position)
	else:
		$CanvasLayer/Line2D.add_point(global_position)

# ================================
# Movement
# ================================

func move(delta):
	vel += accel * delta
	
	var collision = move_and_collide(vel * delta)
	if collision != null:
		collide(collision.collider)
	
	#if (position.y + radius >= res.y):
	#	vel.y = -vel.y
	#	position.y = res.y - 1 - radius
	#if (position.y - radius < 0):
	#	vel.y = -vel.y
	#	position.y = radius
	#if (position.x + radius >= res.x):
	#	vel.x = -vel.x
	#	position.x = res.x - 1 - radius
	#if (position.x - radius < 0):
	#	vel.x = -vel.x
	#	position.x = radius
	
	updateLine()

func collide(obj):
	if obj.mass > mass:
		obj.updateValues(obj.mass + mass)
		queue_free()
		return
	
	if obj.mass == mass:
		if obj.get_instance_id() > get_instance_id():
			obj.updateValues(obj.mass + mass)
			get_parent().remove_child(self)
			queue_free()
			return

# ================================
# Gravity
# ================================

func applyGravity(objects, delta):
	if immovable:
		return
	
	var force = Vector2()
	
	for o in objects:
		if o == self:
			continue
		
		var r = pow(position.distance_to(o.position), 2)
		var F = G * (mass * o.mass) / r
		F *= position.direction_to(o.position)
		
		force += F
	
	accel = force / pow(mass, 2)
	move(delta)
