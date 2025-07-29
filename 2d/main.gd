extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#new_game()

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	print("start game")
	
func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_start_timer_timeout():
	print("start timer timeout")
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	print("mob spawn start")
#	创建一个新的怪物场景实例
	var mob = mob_scene.instantiate() as RigidBody2D
	print(mob.to_string())
	# 在Path2D上选择一个随机路径
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	# 将怪物位置设为这个随机位置
	mob.position = mob_spawn_location.position
	
	# 将怪物的方向设置为垂直于路径的方向
	var direction = mob_spawn_location.rotation + PI / 2
	
	# 为这个方向添加一些随机性
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# 选择怪物的速度
	var velocity = Vector2(randf_range(150, 250), 0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# 生成怪物
	add_child(mob)
	
	
