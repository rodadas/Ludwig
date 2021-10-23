extends Area



onready var player =get_parent().get_parent().get_node("coelho")
# Called when the node enters the scene tree for the first time.
#func _ready():



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Area3_body_entered(body):
	print(player.dead)
	print("hello")
	player.dead=true
