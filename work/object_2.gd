extends Node

signal finished


func do_hard_stuff() -> void:
	print("%s start doing hard stuff" % name)
	await get_tree().create_timer(2).timeout
	print("%s has done hard stuff" % name)
	finished.emit()
