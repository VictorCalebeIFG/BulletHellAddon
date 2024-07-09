@tool
extends Node2D
class_name EnemyBullet

## Add gravity 
@export var gravity = false
@export var randon_speed = false
@export var min_rando_speed = 100
@export var max_rando_speed = 200

## Gravity weight
@export var weight = 10.0
## Change Gravity
@export var pop = 4.0

var rng = RandomNumberGenerator.new()

var run_on_editor = false:
	set(roe):
		run_on_editor = roe
		if !run_on_editor:
			position = Vector2.ZERO
		else :
			#create_bullet()
			pass
			
@export var speed = 5
@export_range(0.1, 1, 0.1) var smooth: float = 0.1


@export var bullet:PackedScene:
	set(p_b):
		bullet = p_b
		
var instance:Node
var gravity_timer:Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	gravity_timer = create_gravity_timer()
	if randon_speed:
		speed = rng.randf_range(min_rando_speed,max_rando_speed)
	
	if !get_parent() is EnemyPoints:
		create_bullet()
	pass # Replace with function body.

func _enter_tree():
	if Engine.is_editor_hint() and get_parent() is EnemyPoints:
		set_parent_bullet()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if run_on_editor or !Engine.is_editor_hint():
		
			#print(speed)
		if gravity:
			create_gravity()
		else:
			move_in_line()
	pass


func create_bullet():
	instance = bullet.instantiate()
	add_child(instance)

func set_parent_bullet():
	print("Bullet Seted Automatically")
	if get_parent():
		get_parent().my_bullet = self

func create_gravity_timer():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 100
	timer.start()
	return timer

func create_gravity():
	if gravity_timer:
		var direction = Vector2.UP.rotated(rotation)*speed
		position = position.lerp(position+direction,smooth)
		var time_count = gravity_timer.wait_time-gravity_timer.time_left
		position.y += time_count**2 + pop*time_count * weight

func move_in_line():
	var direction = Vector2.UP.rotated(rotation)*speed
	#position = position.lerp(position+direction,smooth)
	position += direction
