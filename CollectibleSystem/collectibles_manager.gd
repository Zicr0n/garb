extends Node
class_name CollectiblesManager

var collectibles = {} # { index : {node : node, collected : boolean}}

func _ready() -> void:
	for i in range(get_children().size()):
		var child : Collectible = get_child(i)
		if child is Collectible:
			collectibles[i] = {"node" : child, "collected" : false}
			var saved_collectibles : Array = Levels.get_saved_collectibles()
			if saved_collectibles.has(i):
				collectibles[i]["collected"] = true
				child.hide()
				continue
			
			child.on_collected.connect(on_collectible_collected.bind(i))

func on_collectible_collected(index):
	collectibles[index].collected = true
	Levels.on_collectible_collected(index)
