zsensitivity = 0.1
sprite.xscale = spritexscale + (sqrt(abs(zspeed)) * sign(zspeed) * zsensitivity)
sprite.yscale = spriteyscale - (sqrt(abs(zspeed)) * sign(zspeed) * zsensitivity)

sprite_shadow.xscale = sprite_get_width(sprite.sprite) / 32 * 0.6
sprite_shadow.yscale = sprite_get_height(sprite.sprite) / 32 * 0.25