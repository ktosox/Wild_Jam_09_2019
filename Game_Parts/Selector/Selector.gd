extends Node2D

#selector recieves calls from board
#sets the the selection boxes accoridngly

#origin and gaol are defined in board space / not global cords

var origin # starting point of the selection chain

var goal # end poinbt of the selection chain

func _ready():
	pass

func setChain():
	var path = getPath()
	while (path.size()>0):
		pass
	pass

func getPath():
	#returs an array of vectors - every vector is a single link in the chain
	pass