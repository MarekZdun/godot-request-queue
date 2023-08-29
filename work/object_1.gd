extends Node

signal finished


func do_easy_stuff() -> void:
	print("%s start doing easy stuff" % name)
	await get_tree().create_timer(1).timeout
	print("%s has done easy stuff" % name)
	finished.emit()
	
