#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $im = Imlib2.new();
# load an image
my $loadedimage = $im.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set();

# create a new raw image
my $rawimage = $im.create_image(200, 200);
exit() unless $rawimage;

$rawimage.context_set();

$im.context_set_color(
	red   => 255,
	green => 0,
	blue  => 0,
	alpha => 255
);

$im.image_draw_rectangle(
	location => (0, 0),
	size     => (200, 200),
	fill     => True
);

$loadedimage.context_set();

$im.blend_image_onto_image(
	source_image       => $rawimage,
	merge_alpha        => True,
	source_x           => 0,
	source_y           => 0,
	source_width       => 200,
	source_height      => 200,
	destination_x      => 100,
	destination_y      => 100,
	destination_width  => 261,
	destination_height => 243
);

$im.image_set_format("png");
unlink("images/test_blend.png") if "images/test_blend.png".IO ~~ :e;
$im.save_image("images/test_blend.png");
$im.free_image();

$rawimage.context_set();
$im.free_image();

exit();
