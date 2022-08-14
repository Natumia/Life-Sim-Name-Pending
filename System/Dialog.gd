extends Control

onready var rich_text_label = $RichTextLabel
onready var timer = $Timer
onready var end_sprite = $EndSprite
onready var question_box = $QuestionBox
onready var selection_sprite = $QuestionBox/SelectionSprite

var isQuestion := false
var questionAnswer := true
var confirm := ""
var deny := ""

func message(text):
	rich_text_label.percent_visible = 0
	rich_text_label.text = text
	isQuestion = false
	timer.start()

func question(text, yes_reply, no_reply):
	rich_text_label.percent_visible = 0
	rich_text_label.text = text
	isQuestion = true
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
		
		elif isQuestion == false and rich_text_label.percent_visible == 1:
			self.queue_free()\
		
		elif isQuestion == true and question_box.visible == true and rich_text_label.percent_visible == 1:
			if questionAnswer == true:
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
		questionAnswer = false
	else:
		selection_sprite.position.y = 15
		questionAnswer = true

func end_statement():
	if isQuestion == true:
		question_box.visible = true
	else:
		end_sprite.visible = true
	timer.stop()
