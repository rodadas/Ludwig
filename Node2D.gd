extends Node2D


onready var label = get_node("Label2")

var pause=false

var visi=false
 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if pause==false:
			self.visible=true
			pause=true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().paused=true
		elif pause==true:
			self.visible=false
			pause=false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			get_tree().paused=false


func _on_Button_pressed():
	if visi==false:
		label.visible=true
		visi=true
	elif visi==true:
		label.visible=false
		visi=false
