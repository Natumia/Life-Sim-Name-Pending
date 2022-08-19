extends Control

class_name WindowClass

export(Texture) var windowBackground 

var openedWindows := []

func _ready():
	create_window("Money", Vector2( 20, 20), Vector2(80, 68))
#	create_window(Vector2(118, 20), Vector2(236, 68))
#	create_window(Vector2(20, 68), Vector2(236, 204))

func create_window(inputName : String, topLeft : Vector2, bottomRight : Vector2):
	var newWindow = NinePatchRect.new()
	newWindow.name = inputName + "Window"
	self.add_child(newWindow)
	newWindow.texture = windowBackground
	var backgroundWidth = windowBackground.get_width()
	var backgroundHeight = windowBackground.get_height()
	newWindow.region_rect = Rect2(0, 0, backgroundWidth, backgroundHeight)
	newWindow.patch_margin_bottom = backgroundHeight/3
	newWindow.patch_margin_top = backgroundHeight/3
	newWindow.patch_margin_left = backgroundWidth/3
	newWindow.patch_margin_right = backgroundWidth/3
	newWindow.rect_min_size = Vector2(backgroundWidth, backgroundHeight)
	newWindow.margin_left = topLeft.x
	newWindow.margin_top = topLeft.y
	newWindow.margin_bottom = bottomRight.y
	newWindow.margin_right = bottomRight.x
	openedWindows.append(newWindow)

func close_windows():
	for i in openedWindows:
		i.queue_free()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		close_windows()
