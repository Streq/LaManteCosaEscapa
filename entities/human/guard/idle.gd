extends State

var responds_to_alarm = true
var responds_to_noise = true
func physics_update(delta):
	var target_body = get_tree().get_nodes_in_group("player")[0].body
	var body = get_parent().get_parent()
	var memory = body.get_node("memory")
	
	if memory.suspects(target_body) and body.get_node("vista").can_see(target_body):
		var current_dist_vec : Vector2 = target_body.global_position - body.global_position
		
		body.point_to(current_dist_vec.angle())
		memory.remember(target_body)
		emit_signal("finish", "alert", null)
		
