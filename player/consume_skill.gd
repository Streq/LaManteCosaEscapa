extends Skill

onready var area = $Area2D

var states = ["idle", "walk"]

func trigger()->bool:
	var consumable = get_consumable()
	if consumable != null:
		owner.state.current.emit_signal("finish", "consume", [consumable])
		return true
	return false
func get_consumable():
	if owner.state.current.name in states:
		var consumables = area.get_overlapping_areas()
		if consumables.size():
			var consumable = consumables[0]
			if (
				is_instance_valid(consumable) and 
				is_instance_valid(consumable.owner) and 
				!consumable.owner.vista.can_see(owner) and
				consumable.owner.alive
			):
				return consumable.owner 
	return null
func _physics_process(delta):
	self.usable = get_consumable() != null
