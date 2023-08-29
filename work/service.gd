extends Node

signal finished
signal all_request_finished

var _queue: Array[Array] = []
var _busy: bool = false


func post_request(request: Array, callback: Callable):
	_queue.push_back([request, callback])
	if not _busy:
		_handle_next_request()
		
		
func is_all_request_finished() -> bool:
	var all_finished := false
	if _queue.is_empty() and !_busy:
		all_finished = true
	
	return all_finished
		
		
func _handle_next_request():
	if _queue.size() > 0:
		var entry := _queue.pop_front() as Array
		var request := entry[0] as Array
		var callback := entry[1] as Callable
		_handle(request)
		await finished
		if not callback.is_null():
			callback.call()
		_handle_next_request()
	else:
		all_request_finished.emit()
		
		
func _handle(request: Array):
	_busy = true
	var request_function := request[0] as Callable
	var request_signal := request[1] as Signal
	if not request_function.is_null() and not request_signal.is_null():
		request_function.call()
		await request_signal
	await get_tree().process_frame
	_busy = false
	emit_signal("finished")
	
