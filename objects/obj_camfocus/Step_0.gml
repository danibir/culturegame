x += xoffset
y += yoffset

var xside = sign(xoffset)
xoffset -= offsetdecay * xside
if sign(xoffset) != xside
	xoffset = 0
	
var yside = sign(yoffset)
yoffset -= offsetdecay * yside
if sign(yoffset) != yside
	yoffset = 0