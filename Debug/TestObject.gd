extends Area2D

signal Dialogue

func interact():
	print("Hello World!")
	emit_signal("Dialogue")
