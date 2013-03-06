#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $tools = Imlib2.new();
# load an image
my $loadedimage = $tools.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set_image();

#Creates a new empty color range
my $color_range = $tools.create_color_range();

# Sets the current color range to use for rendering gradients.
$color_range.context_set_color_range();

# Returns the current color range being used for gradients. 
say "Yes I'm a color range." if $tools.context_get_color_range();

$tools.context_set_color(
	red   => 255,
	green => 0,
	blue  => 0,
	alpha => 255
);

# Adds the current color to the current color range at a distance_away
# distance from the previous color in the range.
$tools.add_color_to_color_range(0);

# Another way to set color, alpha is optional.
$tools.context_set_color("#0000FF");
$tools.add_color_to_color_range(1);

$tools.context_set_color(
	red   => 0,
	green => 255,
	blue  => 0,
	alpha => 127
);
$tools.add_color_to_color_range(2);

#
# Draw rectangles w/ RGBA gradient
#
$tools.image_fill_color_range_rectangle(
	x      => 10,
	y      => 10,
	width  => 240,
	height => 50,
	angle  => -90.2e0 # -90.0
);

#
# Draw rectangle w/ HSVA gradient
#
$tools.image_fill_hsva_color_range_rectangle(
	x      => 10,
	y      => 70,
	width  => 240,
	height => 50,
	angle  => 60.0e0 # 60.0
);

# Frees the current color range.
$tools.free_color_range();

$tools.image_set_format("png");
unlink("images/test_color_range.png") if "images/test_color_range.png".IO ~~ :e;
$tools.save_image("images/test_color_range.png");
$tools.free_image();

exit();
