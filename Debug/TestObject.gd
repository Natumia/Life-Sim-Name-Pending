extends Area2D

export(Array, String) var messages

var messageIndex = 0

signal Dialogue

func interact():
	if messages.size() != 0:
		emit_signal("Dialogue", messages[messageIndex % messages.size()])
		messageIndex += 1

