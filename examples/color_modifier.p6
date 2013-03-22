#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use NativeCall;
use Imlib2;

my $im = Imlib2.new();

# load an image
my $loadedimage = $im.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set();

# When rendering an image to a drawable, Imlib2 is able to blend the
# image directly onto the drawable during rendering. Setting this to True
# will enable this. If the image has no alpha channel this has no effect.
# Setting it to False will disable this.
$im.context_set_blend(True);

# Sets the alpha flag for the current image. Set has_alpha to True to enable
# the alpha channel in the current image, or False to disable it.
$im.image_set_has_alpha(False);

my $color_modifier = $im.create_color_modifier();

$color_modifier.context_set();

# Initialize array tables
my @red_table := CArray[int8].new();
@red_table[$_] = 255 for 0..255;	# init array
@red_table[0] = 0;
@red_table[10] = 10;
@red_table[255] = 255;

my @green_table := CArray[int8].new();
@green_table[$_] = 0 for 0..255;	# init array
@green_table[0] = 0;
@green_table[10] = 10;
@green_table[255] = 255;

my @blue_table := CArray[int8].new();
@blue_table[$_] = 255 for 0..255;	# init array
@blue_table[0] = 0;
@blue_table[10] = 10;
@blue_table[255] = 255;

my @alpha_table := CArray[int8].new();
@alpha_table[$_] = 255 for 0..255;
@alpha_table[0] = 0;
@alpha_table[10] = 10;
@alpha_table[255] = 255;

$im.set_color_modifier_tables(@red_table, @green_table, @blue_table, @alpha_table);
$im.get_color_modifier_tables(@red_table, @green_table, @blue_table, @alpha_table);

$im.apply_color_modifier_to_rectangle(
	x      => 20,
	y      => 20,
	width  => 200,
	height => 200
);

$im.image_set_format("png");
unlink("images/test_color_modifier.png") if "images/test_color_modifier.png".IO ~~ :e;
$im.save_image("images/test_color_modifier.png");
$im.free_image();

exit();
