#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $tools = Imlib2.new();
# load an image
my $loadedimage = $tools.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set_image();

# create a new raw image
my $rawimage = $tools.create_image(200, 200);
exit() unless $rawimage;

$rawimage.context_set_image();

$tools.context_set_color(
	red   => 255,
	green => 0,
	blue  => 0,
	alpha => 255
);

$tools.image_fill_rectangle(
	x      => 0,
	y      => 0,
	width  => 200,
	height => 200
);

$loadedimage.context_set_image();

$tools.blend_image_onto_image(
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

$tools.image_set_format("png");
unlink("images/test_blend.png") if "images/test_blend.png".IO ~~ :e;
$tools.save_image("images/test_blend.png");
$tools.free_image();

$rawimage.context_set_image();
$tools.free_image();

exit();
