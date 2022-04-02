/// @description Insert description here
// You can write your code in this editor
var destroy;
if auto_destroy
{
    destroy = 0
    if ((auto_destroy_dir == 90) && (y < 0))
        destroy = 1
    if ((auto_destroy_dir == 270) && (y > 480))
        destroy = 1
    if ((auto_destroy_dir == 180) && (x < 0))
        destroy = 1
    if ((auto_destroy_dir == 0) && (y > 640))
        destroy = 1
    if destroy
        instance_destroy()
}