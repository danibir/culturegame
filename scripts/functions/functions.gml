function alignToGrid (grid, xcenter = true, ycenter = true) {
	x = round((x) / grid) * grid
	y = round((y) / grid) * grid
	if xcenter = true
		x += grid/2
	if ycenter = true
		y += grid/2
}

/// instance_nth_nearest(x,y,obj,n)
//
// Returns the id of the nth nearest instance of an object
// to a given point or noone if none is found.
//
// x,y point coordinates, real
// obj object index (or all), real
// n proximity, real
//
/// GMLscripts.com/license
function instance_nearest_nth(pointx, pointy, object, n) {
	n = min(max(1,n),instance_number(object))
	var list = ds_priority_create()
	var nearest = noone
	with (object) ds_priority_add(list,id,distance_to_point(pointx,pointy))
	repeat (n) nearest = ds_priority_delete_min(list)
	ds_priority_destroy(list)
	return nearest
}