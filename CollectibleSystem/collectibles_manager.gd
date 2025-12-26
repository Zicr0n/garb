extends Node
class_name CollectiblesManager

var collectibles = {} # { index : {node : node, collected : boolean}}

func _ready() -> void:
	for i in range(get_children().size()):
		var child : Collectible = get_child(i)
		if child is Collectible:
			collectibles[i] = {"node" : child, "collected" : false}
			child.on_collected.connect(on_collectible_collected.bind(i))

func on_collectible_collected(index):
	collectibles[index].collected = true
