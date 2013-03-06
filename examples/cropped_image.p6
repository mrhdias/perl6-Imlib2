#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $tools = Imlib2.new();
# load an image
my $loadedimage = $tools.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set_image();

# Creates a duplicate of a (x, y, width, height) rectangle in the
# current image
my $cropped = $tools.create_cropped_image(
	x      => 0,
	y      => 0,
	width  => 150,
	height => 150
);

# Sets the cropped image the current image Imlib2 will be using with its
# function calls.
$cropped.context_set_image();

$tools.context_set_color(
	red   => 255,
	green => 0,
	blue  => 255,
	alpha => 127
);

$tools.image_draw_rectangle(
	x      => 10,
	y      => 10,
	width  => 150 - 20,
	height => 150 - 20
);

$tools.image_set_format("png");
unlink("images/test_cropped.png") if "images/test_cropped.png".IO ~~ :e;
$tools.save_image("images/test_cropped.png");
$tools.free_image();

# Sets the original image the current image Imlib2 add free it.
$loadedimage.context_set_image();
$tools.free_image();

exit();
