extends Node2D

onready var area = $Area2D

func activate():
	activate_target(global_position, null)
		

func activate_target(target_position, who):
	var listeners = area.get_overlapping_areas()
	for listener in listeners:
		listener._on_scream(self, target_position, who)
	
