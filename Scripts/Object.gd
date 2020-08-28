# Node Tree:
#
# KinematicBody2D (Object)
#   CollisionShape2D (CollisionShape2D)

extends KinematicBody2D

export (int) var mass
export (bool) var immovable = false
export (Vector2) var dir
export (int) var speed

const G = 667.4
const LPT = 512

var radius
var vel = Vector2()
var accel = Vector2()

func _ready():
	radius = sqrt(mass)
	vel = dir * speed
	
	var shape = CircleShape2D.new()
	shape.set_radius(radius)
	$CollisionShape2D.shape = shape

func _draw():
	draw_circle(Vector2(), radius, Color(1, 1, 1, 1))

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
	
	accel = force / mass
	
	vel += accel * delta
	vel = move_and_slide(vel)
	
	if $CanvasLayer/Line2D.get_point_count() > LPT:
		$CanvasLayer/Line2D.remove_point(0);
	
	if $CanvasLayer/Line2D.get_point_count() > 0:
		if $CanvasLayer/Line2D.get_point_position($CanvasLayer/Line2D.get_point_count() - 1) != global_position:
			$CanvasLayer/Line2D.add_point(global_position)
	else:
		$CanvasLayer/Line2D.add_point(global_position)
