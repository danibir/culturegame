var radius = 4
var force = 0.2

var closeness = max(0, radius - distance_to_object(other)) / radius
var dir = point_direction(x, y, other.x, other.y)
var _xspd = lengthdir_x(force * closeness, dir)
var _yspd = lengthdir_y(force * closeness, dir)
xspeed -= _xspd
yspeed -= _yspd
other.xspeed += _xspd
other.yspeed += _yspd