extends Node

@onready var object_1 = $Object_1
@onready var object_2 = $Object_2
@onready var object_3 = $Object_3


func _ready():
	Service.post_request([object_1.do_easy_stuff, object_1.finished], write_msg.bind(object_1.name))
	Service.post_request([object_2.do_hard_stuff, object_2.finished], write_msg.bind(object_2.name))
	Service.post_request([object_3.do_hard_stuff, object_3.finished], write_msg.bind(object_3.name))
	await Service.all_request_finished
	print("all request was finished")
	
	
func write_msg(msg: String):
	print("after request: %s" % msg)
