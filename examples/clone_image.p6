#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $tools = Imlib2.new();
# load an image
my $loadedimage = $tools.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set_image();

# Creates an exact duplicate of the current image.
my $clone = $tools.clone_image();

# Sets the clone the current image Imlib2 will be using with its
# function calls.
$clone.context_set_image();

$tools.context_set_color(
	red   => 0,
	green => 0,
	blue  => 255,
	alpha => 127
);

$tools.image_draw_rectangle(
	x      => 10,
	y      => 10,
	width  => $tools.image_get_width() - 20,
	height => $tools.image_get_height() - 20
);

$tools.image_set_format("png");
unlink("images/test_clone.png") if "images/test_clone.png".IO ~~ :e;
$tools.save_image("images/test_clone.png");
$tools.free_image();

# Sets the original image the current image Imlib2 add free it.
$loadedimage.context_set_image();
$tools.free_image();

exit();
