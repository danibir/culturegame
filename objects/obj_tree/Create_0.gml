sprite = instance_create_layer(x, y, "Instances", obj_sprite)
sprite.body = self
sprite.xscale *= 1 * choose(1, -1) + random_range(0, 0.1) * choose(1, -1)
sprite.yscale *= 1 + random_range(0, 0.1) * choose(1, -1)
var shade = random_range(0.025, 0.075)
sprite.col = make_colour_rgb(233 * shade, 233 * shade, 233 * shade)
touched = false
seen = false