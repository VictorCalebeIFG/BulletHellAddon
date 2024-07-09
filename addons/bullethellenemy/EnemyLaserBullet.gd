@tool
extends RayCast2D
class_name EnemyLaserBullet

@export var distance = 300:
	set(dis):
		distance = dis
		target_position.y = -distance

@export var my_line2d: Line2D:
	set(l2d):
		my_line2d = l2d
		set_line2d()

var on_start_instance
@export var on_start:PackedScene:
	set(o_s):
		on_start = o_s
		if my_line2d and on_start:
			add_on_start()
		else:
			remove_child(on_start_instance)
			on_end_instance = null
		

var on_end_instance
@export var on_end:PackedScene:
	set(o_e):
		on_end = o_e
		if my_line2d and on_end:
			add_on_end()
		else:
			remove_child(on_end_instance)
			on_end_instance = null
		
			

func _ready():
	add_on_start()
	add_on_end()
	pass

func set_line2d():
	print("Line Seted")
	if my_line2d:
		my_line2d.clear_points()
		my_line2d.add_point(Vector2.ZERO)
		my_line2d.add_point(Vector2(0,target_position.y))
		pass

func update_laser():
	force_raycast_update()
	if is_colliding():
		my_line2d.points[1] = to_local(get_collision_point())
		if on_end_instance:
			on_end_instance.position = my_line2d.points[-1]
	else:
		var mod = target_position.y
		my_line2d.points[1] = Vector2.UP * (-mod)
		if on_end_instance:
			on_end_instance.position = my_line2d.points[-1]

func _process(delta):
	update_laser()

func add_on_start():
	on_start_instance = on_start.instantiate()
	add_child(on_start_instance)
	on_start_instance.position = my_line2d.points[0]

func add_on_end():
	on_end_instance = on_end.instantiate()
	add_child(on_end_instance)
	on_end_instance.position = my_line2d.points[-1]
