extends KinematicBody2D


export var speed : int = 10

#var velocity = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(1) :
		follow_mouse()
	pass



func follow_mouse() :
	var mouse_pos_vect = get_local_mouse_position().normalized()
	var velocity = lerp(Vector2.ZERO, mouse_pos_vect * speed, 0.5)
	move_and_collide(velocity)
