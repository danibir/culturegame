sprite = instance_create_layer(x, y, "Instances", obj_sprite)
sprite.body = self
sprite.yscale *= 1 + random_range(0, 0.1) * choose(1, -1)
sprite.xscale *= 1 + random_range(0, 0.1) * choose(1, -1)
var shade = random_range(0, 0.2)
sprite.col = make_colour_rgb(233 * shade, 233 * shade, 233 * shade)
touched = false
seen = false