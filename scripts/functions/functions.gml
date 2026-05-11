function alignToGrid (grid, xcenter = true, ycenter = true) {
	x = round((x) / grid) * grid
	y = round((y) / grid) * grid
	if xcenter = true
		x += grid/2
	if ycenter = true
		y += grid/2
}