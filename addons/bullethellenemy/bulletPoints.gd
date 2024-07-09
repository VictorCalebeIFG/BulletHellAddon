@tool
extends Line2D
class_name EnemyPoints

var BulletBucket
var test_mode_timer:Timer

@export var test_time: float = 1.05:
	set(t_t):
		test_time = t_t
		if test_mode_timer:
			test_mode_timer.wait_time = test_time

@export var world :Node:
	set(p_world):
		world = p_world 
		if Engine.is_editor_hint():
			create_bullet_bucket()
		if world:
			BulletBucket = world.get_node("BulletBucket")
@export var my_bullet:Node
@export var test_mode:bool:
	set(p_test_mode):
		test_mode = p_test_mode
		if Engine.is_editor_hint():
			if test_mode:
				print("Shoott")
				#shoot()
				set_test_mode_on()
			else:
				for c in world.get_node("BulletBucket").get_children():
					c.queue_free()
				if test_mode_timer:
					test_mode_timer.stop()
@export var life_time = 2.0
@export var local_bullet = false

func _ready():
	set_world()
	pass
	
	pass # Replace with function body.
func _input(event):
	pass

func _process(delta):
	pass

func create_bullet_bucket():
	if world and !world.has_node("BulletBucket"):
		print("Creating a Bullets Node in your World Env")
		var BulletBucket = Node2D.new()
		world.add_child(BulletBucket)
		BulletBucket.owner = get_tree().edited_scene_root
		BulletBucket.name = "BulletBucket"

func _set(property, value):
	pass

	
func shoot():
	for pos in points:
		var bullet = my_bullet.duplicate()
		bullet = rotate_bullet_to_position(bullet,pos)
		if !local_bullet:
			BulletBucket.add_child(bullet)
		else:
			get_parent().add_child(bullet)
		add_timer_to_bullet(bullet)
		if Engine.is_editor_hint():
			bullet.run_on_editor = true

func delete_all():
	for c in BulletBucket.get_children():
		c.queue_free()

func set_world():
	if Engine.is_editor_hint():
		world = get_parent().get_parent()
		width = 1
		

func rotate_bullet_to_position(bullet:EnemyBullet,pos):
	if !local_bullet:
		bullet.global_position = pos+get_parent().position
		var rot = rad_to_deg(bullet.position.angle_to_point(get_parent().position))
		bullet.rotation_degrees = rot - 90
	else:
		bullet.position = pos
		var rot = rad_to_deg((pos+get_parent().position).angle_to_point(get_parent().position))
		bullet.rotation_degrees = rot - 90
	return bullet

func add_timer_to_bullet(bullet:EnemyBullet):
	var timer = Timer.new()
	timer.wait_time = life_time
	bullet.add_child(timer)
	timer.connect("timeout",func(): if bullet: bullet.queue_free())
	timer.start()

func set_test_mode_on():
	test_mode_timer = Timer.new()
	add_child(test_mode_timer)
	test_mode_timer.wait_time = test_time
	test_mode_timer.start()
	test_mode_timer.one_shot = false
	test_mode_timer.connect("timeout",func():shoot())
	
	
