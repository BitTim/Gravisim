# Node Tree:
#
# KinematicBody2D (Object)
#   CollisionShape2D (CollisionShape2D)

extends KinematicBody2D

export (int) var radius
export (int) var mass

const G = 6674

var vel = Vector2()
var accel = Vector2()

func _ready():
  var shape = CircleShape2D.new()
  shape.set_radius(radius)
  
  $CollisionShape2D.shape = shape

func _draw():
  draw_circle(Vector2(), radius, Color(1, 1, 1, 1))

func applyGravity(objects, delta):
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
