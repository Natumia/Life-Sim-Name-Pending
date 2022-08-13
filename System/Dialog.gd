extends Control

onready var rich_text_label = $RichTextLabel
onready var timer = $Timer
onready var end_sprite = $EndSprite

var text := "Hello, thank you for watching and if you enjoy this, please subscribe!"
var is_question := false

func _ready():
	rich_text_label.text = text
	timer.start()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if rich_text_label.percent_visible < 1:
			rich_text_label.percent_visible = 1
			end_statement()
		else:
			self.queue_free()

func _on_Timer_timeout():
	rich_text_label.visible_characters += 1
	if rich_text_label.percent_visible == 1:
		end_statement()

func end_statement():
	timer.stop()
	end_sprite.visible = true
