#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $im = Imlib2.new();
my $newimage = $im.create_image(200, 200);
exit() unless $newimage;

# Sets the current image Imlib2 will be using with its function calls.
$newimage.context_set();

$im.image_set_has_alpha(True);

# Sets the color with which text, lines and rectangles are drawn when
# being rendered onto an image.
$im.context_set_color(
	red   => 10,
	green => 127,
	blue  => 200,
	alpha => 255
);

my %color_channels = (
	red     => 0,
	green   => 0,
	blue    => 0,
	alpha   => 0,
	hexcode => "#000000"
);
$im.context_get_color(%color_channels);
say "Pass hash colors as argument:";
say "-----------------------------";
say "__Red: " ~ %color_channels{'red'};
say "Green: " ~ %color_channels{'green'};
say "_Blue: " ~ %color_channels{'blue'};
say "Alpha: " ~ %color_channels{'alpha'};
say "__Hex: " ~ %color_channels{'hexcode'};

%color_channels = $im.context_get_color();
say "\nReturn hash colors:";
say "-----------------------------";
say "__Red: " ~ %color_channels{'red'};
say "Green: " ~ %color_channels{'green'};
say "_Blue: " ~ %color_channels{'blue'};
say "Alpha: " ~ %color_channels{'alpha'};
say "__Hex: " ~ %color_channels{'hexcode'};

$im.image_draw_rectangle(
	location => (0, 0),
	size     => (200, 200),
	fill     => True);

# Another way to set a color (color, alpha).
# alpha is optional and the deafult value is 255.

$im.context_set_color(0xff0000ff);

$im.image_draw_rectangle(
	location => (0, 0),
	size     => (200 - 20 , 200 - 20));

$im.image_set_format("png");
unlink("images/test_imlib2.png") if "images/test_imlib2.png".IO ~~ :e;
$im.save_image("images/test_imlib2.png");

# Frees the image that is set as the current image in Imlib2's context. 
$im.free_image();

exit();
