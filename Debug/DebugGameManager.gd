extends Node2D

func _ready():
	refresh_connections()

func pause_player(state):
	var player = get_node_or_null("DebugMap/Player")
	if player != null:
		player.is_paused(state)
	if state == true:
		pass

func refresh_connections():
	var dialogBox = get_node_or_null("Dialog/DialogueBox")
	for i in get_tree().get_nodes_in_group("Interactable"):
		i.connect("Dialogue", get_node("Dialog/DialogueBox"), "message")
	if dialogBox != null:
		dialogBox.connect("Window_State", self, "pause_player")
