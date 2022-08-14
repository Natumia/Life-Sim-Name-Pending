extends Control

onready var rich_text_label = $RichTextLabel
onready var timer = $Timer
onready var end_sprite = $EndSprite
onready var question_box = $QuestionBox
onready var selection_sprite = $QuestionBox/SelectionSprite

var is_question := false
var question_answer := true
var confirm := ""
var deny := ""

func message(text):
	rich_text_label.percent_visible = 0
	rich_text_label.text = text
	is_question = false
	timer.start()

func question(text, yes_reply, no_reply):
	rich_text_label.percent_visible = 0
	rich_text_label.text = text
	is_question = true
	confirm = yes_reply
	deny = no_reply
	timer.start()

func _ready():
	message("Well, it seems I have built a basic Dialog system that supports a yes or no question. Nervous how entities will use it.")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if rich_text_label.percent_visible < 1:
			rich_text_label.percent_visible = 1
			end_statement()
		
		elif is_question == false and rich_text_label.percent_visible == 1:
			self.queue_free()\
		
		elif is_question == true and question_box.visible == true and rich_text_label.percent_visible == 1:
			if question_answer == true:
				message(confirm)
			else:
				message(deny)
			question_box.visible = false
	
	if event.is_action_pressed("ui_down") and question_box.visible == true:
		selection_sprite.position.y += 30
		selection_state()
	if event.is_action_pressed("ui_up") and question_box.visible == true:
		selection_sprite.position.y -= 30
		selection_state()

func _on_Timer_timeout():
	rich_text_label.visible_characters += 1
	if rich_text_label.percent_visible == 1:
		end_statement()

func selection_state():
	if int(selection_sprite.position.y) % 45 < 15:
		selection_sprite.position.y = 45
		question_answer = false
	else:
		selection_sprite.position.y = 15
		question_answer = true

func end_statement():
	if is_question == true:
		question_box.visible = true
	else:
		end_sprite.visible = true
	timer.stop()
