extends State
var body = null
onready var sound = $alert_sound
func enter(params):
	body = get_parent().get_parent()
	$reaction_time.start()
	sound.play()
func exit():
	$reaction_time.stop()

func _on_reaction_time_timeout():
	emit_signal("finish", "sound_the_alarm", null)
		
func physics_update(delta):
	
	#	look for target
	var target_body = get_tree().get_nodes_in_group("player")[0].body
	if body.memory.suspects(target_body) and body.get_node("vista").can_see(target_body):
		var current_dist_vec : Vector2 = target_body.global_position - body.global_position
			
		body.point_to(current_dist_vec.angle())
		body.dir = Vector2()
		
		body.memory.remember(target_body)
		body.yell.activate_target(body.memory.target_position, target_body)
		body.expression_anim.play("alert")

