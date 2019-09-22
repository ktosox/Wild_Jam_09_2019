extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var boxName = "name"

# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/Name.text = boxName
	
	pass # Replace with function body.

func setValue(value = " "):
	$CenterContainer/Value.text = value
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
