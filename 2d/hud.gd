extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessgaeTimer.start()

func show_game_over():
	show_message("Game Over")
	await $MessgaeTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	
	#await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_messgae_timer_timeout() -> void:
	$Message.hide()

func _on_start_button_pressed() -> void:
	$StartButton.hide()
	start_game.emit()
