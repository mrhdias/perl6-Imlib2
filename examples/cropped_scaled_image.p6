#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $tools = Imlib2.new();
# load an image
my $loadedimage = $tools.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set_image();

# Works the same as create_cropped_image() but will scale the new image
# to the new destination destination_width and destination_height whilst
# cropping.
my $cropped_scaled = $tools.create_cropped_scaled_image(
	source_x           => 0,
	source_y           => 0,
	source_width       => $tools.image_get_width(),
	source_height      => $tools.image_get_height(),
	destination_width  => 150,
	destination_height => 150
);

# Sets the cropped scaled image the current image Imlib2 will be using
# with its function calls.
$cropped_scaled.context_set_image();

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
unlink("images/test_cropped_scaled.png") if "images/test_cropped_scaled.png".IO ~~ :e;
$tools.save_image("images/test_cropped_scaled.png");
$tools.free_image();

# Sets the original image the current image Imlib2 add free it.
$loadedimage.context_set_image();
$tools.free_image();

exit();
