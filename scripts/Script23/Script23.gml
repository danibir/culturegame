function isVisible (instance=self) {
	return seenBy(instance, obj_entity_player)
}
function seenBy (target, issuer) {
	if instance_exists(issuer)
		return (!collision_line(target.x, target.y, issuer.x, issuer.y, obj_wall, false, true) 
		and point_distance(target.x, target.y, issuer.x, issuer.y) < issuer.sightDistance)
	return false
}