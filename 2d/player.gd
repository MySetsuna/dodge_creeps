extends Area2D

signal hit
@export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if velocity.length()>0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	if velocity.y < 0:
		$AnimatedSprite2D.flip_v = false
	if velocity.y > 0:
		$AnimatedSprite2D.flip_v = true
		
	if velocity.y != 0:
		$AnimatedSprite2D.animation = 'up'
	elif  velocity.x != 0:
		$AnimatedSprite2D.animation = 'walk'


func _on_body_entered(_body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	$AnimatedSprite2D.flip_h = true
	$AnimatedSprite2D.flip_v = false
	$AnimatedSprite2D.animation = 'walk'
	show()
	$CollisionShape2D.disabled = false
