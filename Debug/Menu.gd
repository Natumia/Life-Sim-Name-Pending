extends WindowClass

func _ready():
	create_window("Money", Vector2( 20, 20), Vector2(100, 52), windowUse.Info)
	adjust_window("Money", windowProperty.Text, "103,234 G")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		close_window("Money")
