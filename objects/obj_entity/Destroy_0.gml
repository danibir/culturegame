for (var i = 0; i < random_range(240, 260); i++) {
	var debree = instance_create_layer(x, y, "Instances", obj_debree)
	debree.sprite.col = make_colour_rgb(64, 0 ,0)
	debree.xspeed += xspeed * 3
	debree.yspeed += yspeed * 3
	debree.scale = 2
	debree.transparency.startalpha = 0.3
	debree.transparency.endalpha = 0.1
}