zspeed -= zgrav
z += zspeed
if z <= 0 {
	zspeed *= -0.3
	xspeed *= 0.8
	yspeed *= 0.8
	if zspeed <= 0.1
		zspeed = 0
}
if abs(xspeed) <= 0.1 and abs(yspeed) <= 0.1 {
	size -= 1/60 / 30
}
sprite.xscale = size * scale
sprite.yscale = size * scale
sprite.alpha = lerp(transparency.startalpha, transparency.endalpha, size)
if size <= 0 {
	instance_destroy()
}
z = max(0, z)
sprite.yoffset = -z
x += xspeed
y += yspeed