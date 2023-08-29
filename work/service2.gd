#class_name Service

signal finished

var queue: Array
var busy: bool = false


func post_request(request, caller, func_name, arguments):
	queue.push_back([request, caller, func_name, arguments])
	if not busy:
		_handle_next_request()
		
		
func _handle_next_request():
	if queue.size() > 0:
		var entry = queue.pop_front()
		var request = entry[0]
		var caller = entry[1]
		var func_name = entry[2]
		var arguments = entry[3]
		_handle(request)
		await finished
		caller.call(func_name, arguments)
		_handle_next_request()
		
		
func _handle(request):
	busy = true
	# your code...
	busy = false
	emit_signal("finished")
	
