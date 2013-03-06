#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $tools = Imlib2.new();
# load an image
my $loadedimage = $tools.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set_image();

my $polygon = $tools.polygon_new();
exit() unless $polygon;

$polygon.polygon_add_points(
	 50, 50,	# top corner    (w, h)
	200,  0,	# right corner  (w, h)
	180, 180,	# bootom corner (w, h)
	 60, 200	# left corner   (w, h)
);
# add one more point
$polygon.polygon_add_points(20, 160);
# add more two points
$polygon.polygon_add_points(
	50, 100,
	10, 50,
	10, 30
);

if $polygon.polygon_contains_point(200, 0) {
	say "YES contain the point....";
}

$tools.context_set_color(
	red   => 255,
	green => 0,
	blue  => 0,
	alpha => 255
);

$tools.image_draw_polygon($polygon);

$tools.context_set_color(
	red   => 255,
	green => 0,
	blue  => 255,
	alpha => 127
);

$tools.image_fill_polygon($polygon);

$polygon.polygon_free();

$tools.image_set_format("png");
unlink("images/test_polygon.png") if "images/test_polygon.png".IO ~~ :e;
$tools.save_image("images/test_polygon.png");
$tools.free_image();

exit();
