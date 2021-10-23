extends Area


onready var position = get_parent().get_node("Area4").global_transform.origin


onready var player =get_parent().get_parent().get_node("coelho")
# Called when the node enters the scene tree for the first time.
func _ready():
	position.y+=1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):


func _on_Area_body_entered(body):

	player.global_transform.origin=position
	player.y_velo+=90

