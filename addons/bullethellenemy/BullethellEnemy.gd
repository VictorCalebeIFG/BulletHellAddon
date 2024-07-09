@tool
extends EditorPlugin


func _enter_tree():
	print("Bullet Hell plugins is Installed")
	add_custom_type("EnemyPoints","Line2D",preload("bulletPoints.gd"),preload("res://addons/bullethellenemy/icons/bulletpoints.png"))
	add_custom_type("EnemyBullet","Node2D",preload("res://addons/bullethellenemy/Bullet.gd"),preload("res://addons/bullethellenemy/icons/Bullet.svg"))	
	add_custom_type("EnemyLaserBullet","RayCast2D",preload("res://addons/bullethellenemy/EnemyLaserBullet.gd"),preload("res://addons/bullethellenemy/icons/iconLaser.svg"))		
	pass


func _exit_tree():
	remove_custom_type("EnemyPoints")
	remove_custom_type("EnemyBullet")
	remove_custom_type("EnemyLaserBullet")
	pass
