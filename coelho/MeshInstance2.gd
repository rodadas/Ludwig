extends KinematicBody
 
var MOVE_SPEED = 5
const JUMP_FORCE = 20
const GRAVITY = 0.98
const MAX_FALL_SPEED = 30
var state = 0
var run=false
var grounded=false

export var dead= false

var mouse_sensitivity = 0.2

onready var cam= get_node("Area")
onready var anim= get_node("AnimationPlayer")
onready var button=get_parent().get_node("ColorRect") 
onready var label = get_parent().get_node("Label")


export var y_velo = 0
 
func _ready():

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused=false
 
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity)) 
		cam.rotate_z(deg2rad(-event.relative.y * mouse_sensitivity)) 
		cam.rotation.z = clamp(cam.rotation.z, deg2rad(-90), deg2rad(90))
 
func _physics_process(delta):

	if dead==true: 
		get_tree().paused=true
		button.visible=true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		print("dead")
	var move_vec = Vector3()
	if Input.is_action_pressed("ui_up"):
		move_vec.x += 1
		state=1
	if Input.is_action_pressed("ui_down"):
		move_vec.x -= 1
		state=1
	if Input.is_action_pressed("ui_right"):
		move_vec.z -= 1
		state=1
	if Input.is_action_pressed("ui_left"):
		move_vec.z += 1
		state=1
	if Input.is_action_pressed("sprint"):
		run=true
		MOVE_SPEED=10
	else:
		run=false
		MOVE_SPEED=5
	if !Input.is_action_pressed("ui_up")&&!Input.is_action_pressed("ui_right")&&!Input.is_action_pressed("ui_left")&&!Input.is_action_pressed("ui_down"):
		state=0
		
	grounded = is_on_floor()	
		
	if state==0&&grounded:
		anim.play("Action")
	elif grounded==false:
		anim.play("FALL")
	elif state==1&&!run:
		anim.play("WALK")
	elif state==1&&run:
		anim.play("RUN")
	print(y_velo)
		
		
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_vec *= MOVE_SPEED
	move_vec.y = y_velo
	move_and_slide(move_vec, Vector3(0, 1, 0))
 
	
	
	y_velo -= GRAVITY
	var just_jumped = false
	if grounded and Input.is_action_just_pressed("jump"):
		just_jumped = true
		y_velo = JUMP_FORCE
		
	if grounded and y_velo <= 0:
		y_velo = -0.1
	if y_velo < -MAX_FALL_SPEED:
		y_velo = -MAX_FALL_SPEED
 


func _on_Area_body_entered(body):
	label.visible=true
