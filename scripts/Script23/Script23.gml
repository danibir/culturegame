function isVisible (instance=self) {
	if instance_exists(obj_entity_player)
		return (!collision_line(instance.x, instance.y, obj_entity_player.x, obj_entity_player.y, obj_wall, false, true) 
		and point_distance(instance.x, instance.y, obj_entity_player.x, obj_entity_player.y) < obj_entity_player.sightDistance)
	return false
}