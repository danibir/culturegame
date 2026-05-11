
for (var a = 0; a - 1 < room_width / 16; a++) {
	for (var b = 0; b - 1 < room_height / 16; b++) {
		instance_create_layer(a * 16, b * 16, "Instances", obj_wall)
	}
}
instance_create_layer(x, y, "Instances", obj_wrldgen_path)
for (var i = 0; i - 1 < room_width / 16; i++) {
	instance_create_layer(i * 16, 0, "Instances", obj_wall)
	instance_create_layer(i * 16, room_height, "Instances", obj_wall)
}
for (var i = 0; i - 1 < room_height / 16; i++) {
	instance_create_layer(0, i * 16, "Instances", obj_wall)
	instance_create_layer(room_width, i * 16, "Instances", obj_wall)
}
/*
for (var i = 0; i < 50; i++) {
	global.import = choose(1, 3, 5)
	instance_create_layer(random_range(0, room_width), random_range(0, room_height), "Instances", obj_wall_cluster)
}
