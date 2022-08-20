extends Control

class_name WindowClass

export(Texture) var windowBackground 
export(Resource) var windowText

var openedWindows := []

enum windowProperty{
	Text
}

enum windowUse{
	Info,
	Dialogue,
	Menu,
	Custom
}

func _ready():
#	create_window("Money", Vector2( 20, 20), Vector2(100, 52), windowUse.Info)
#	create_window("Time", Vector2(118, 20), Vector2(236, 52), windowUse.Info)
#	create_window("BaseMenu", Vector2(20, 52), Vector2(236, 204), windowUse.Info)
	pass

func create_window(inputName : String, topLeft : Vector2, bottomRight : Vector2, inputUse : int):
	# Instancing the window and name.
	var newWindow = NinePatchRect.new()
	newWindow.name = inputName + "Window"
	
	# Creating the window and positioning.
	self.add_child(newWindow)
	newWindow.texture = windowBackground
	var backgroundWidth = windowBackground.get_width()
	var backgroundHeight = windowBackground.get_height()
	newWindow.region_rect = Rect2(0, 0, backgroundWidth, backgroundHeight)
	newWindow.patch_margin_left = backgroundWidth/3
	newWindow.patch_margin_top = backgroundHeight/3
	newWindow.patch_margin_right = backgroundWidth/3
	newWindow.patch_margin_bottom = backgroundHeight/3
	newWindow.rect_min_size = Vector2(backgroundWidth, backgroundHeight)
	newWindow.margin_left = topLeft.x
	newWindow.margin_top = topLeft.y
	newWindow.margin_bottom = bottomRight.y
	newWindow.margin_right = bottomRight.x
	
	# Used to build the menu structure by building it with the Enum.
	match inputUse:
		windowUse.Info:
			create_text(newWindow)
		windowUse.Dialogue:
			pass
		windowUse.Menu:
			pass
		windowUse.Custom:
			# I will build out custom functions that you append to WindowIDs.
			pass
	
	# Appending the new window into the opened window array.
	openedWindows.append(newWindow)

func create_text(window):
	#Instances the text and name.
	var newText = RichTextLabel.new()
	newText.name = "Text"
	
	# Building the positioning of the text.
	window.add_child(newText)
	var windowSize = window.rect_size
	newText.margin_left = 8
	newText.margin_top = 8
	newText.margin_right = windowSize.x - 8
	newText.margin_bottom = windowSize.y - 8
	newText.scroll_active = false
	
	newText.set("custom_fonts/normal_font", windowText)

func adjust_window(inputWindow : String, inputProperty : int, inputChange):
	# Checks if the window is availible
	var selectedWindow = get_node_or_null(inputWindow + "Window")
	if selectedWindow != null:
		
		# Matching the enum property to make changes.
		match inputProperty:
			windowProperty.Text:
				selectedWindow.get_node("Text").text = inputChange
		
	else:
		print(inputWindow, " doesn't exist for adjusting.")

func close_window(inputWindow : String):
	# Checking if window exists.
	var selectedWindow = get_node_or_null(inputWindow + "Window")
	if selectedWindow != null:
		selectedWindow.queue_free()
		openedWindows.remove(openedWindows.find(selectedWindow))
	else:
		print(inputWindow, " doesn't exist for closing.")

func close_all_windows():
	if !openedWindows.empty():
		for i in openedWindows:
			i.queue_free()
		
		openedWindows.clear()
