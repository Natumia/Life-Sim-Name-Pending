extends Control

signal Window_State

onready var rich_text_label = $RichTextLabel
onready var timer = $Timer
onready var cooldown = $Cooldown
onready var end_sprite = $EndSprite
onready var question_box = $QuestionBox
onready var selection_sprite = $QuestionBox/SelectionSprite

var dialogActive := false

var isQuestion := false
var questionAnswer := true
var confirm := ""
var deny := ""

func message(text):
	if dialogActive != true:
		dialogActive = true
		emit_signal("Window_State", false)
		rich_text_label.percent_visible = 0
		rich_text_label.text = text
		self.visible = true
		isQuestion = false
		timer.start()

func question(text, yes_reply, no_reply):
	if dialogActive != true:
		dialogActive = true
		emit_signal("Window_State", false)
		rich_text_label.percent_visible = 0
		rich_text_label.text = text
		self.visible = true
		isQuestion = true
		confirm = yes_reply
		deny = no_reply
		timer.start()

func _ready():
#	question("Hey there! Just giving an example of the question system and see how it looks! Like it?", "Thank you very much!", "Well shove off then!")
#	message("This is the new text box style. I think it looks pretty nice. Now I need to look into rebuilding this system.")
	pass

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if rich_text_label.percent_visible < 1:
			rich_text_label.percent_visible = 1
			end_statement()
		
		elif isQuestion == false and rich_text_label.percent_visible == 1:
			self.visible = false
			end_sprite.visible = false
			if dialogActive == true and cooldown.get_time_left() == 0:
				cooldown.start()
		
		elif isQuestion == true and question_box.visible == true and rich_text_label.percent_visible == 1:
			if questionAnswer == true:
				message(confirm)
			else:
				message(deny)
			question_box.visible = false
	
	if event.is_action_pressed("ui_down") and question_box.visible == true:
		selection_sprite.position.y += 18
		selection_state()
	if event.is_action_pressed("ui_up") and question_box.visible == true:
		selection_sprite.position.y -= 18
		selection_state()

func _on_Timer_timeout():
	rich_text_label.visible_characters += 1
	if rich_text_label.percent_visible == 1:
		end_statement()

func selection_state():
	if int(selection_sprite.position.y) % 34 < 16:
		selection_sprite.position.y = 34
		questionAnswer = false
	else:
		selection_sprite.position.y = 16
		questionAnswer = true

func end_statement():
	if isQuestion == true:
		question_box.visible = true
	else:
		end_sprite.visible = true
	timer.stop()

func _on_Cooldown_timeout():
	dialogActive = false
	emit_signal("Window_State", true)
