#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $tools = Imlib2.new();
# load an image
my $loadedimage = $tools.load_image("images/camelia-logo.jpg");
exit() unless $loadedimage;

# Sets the current image Imlib2 will be using with its function calls.
$loadedimage.context_set_image();

$tools.add_path_to_font_path("/usr/share/fonts/corefonts");
$tools.font_cache_size(512 * 1024);
my $bytes = $tools.font_cache_size();
say "Font cache size: $bytes";

$tools.context_set_color(
	red   => 255,
	green => 0,
	blue  => 0,
	alpha => 255
);

# load another font: /usr/share/fonts/corefonts/comic.ttf
my $corefont = $tools.load_font("comic", 36);

# Sets the current font to use when rendering text
$corefont.context_set_font();

# Sets the direction in which to draw text in terms of simple 90 degree
# orientations or an arbitrary angle. The direction can be one of:
# TEXT_TO_RIGHT, TEXT_TO_LEFT, TEXT_TO_DOWN, TEXT_TO_UP or TEXT_TO_ANGLE.
# The default is TEXT_TO_RIGHT. If you use TEXT_TO_ANGLE, you will also
# have to set the angle with context_set_angle().
$tools.context_set_direction(TEXT_TO_ANGLE);

say "Text to Angle..." if $tools.context_get_direction() == TEXT_TO_ANGLE;

$tools.context_set_angle(-45.0);

say "Text Direction Angle: " ~ $tools.context_get_angle();

# Draws the null-byte terminated string text using the current font on
# the current image at the (x, y) location (x, y denoting the top left
# corner of the font string).
$tools.text_draw(
	x    => 10,
	y    => 10,
	text => "Imlib2"
);

# load another font: /usr/share/fonts/corefonts/verdana.ttf
my $verdanafont = $tools.load_font("verdana", 24);

# Sets the current font to verdana
$verdanafont.context_set_font();

$tools.context_set_color(
	red   => 0,
	green => 255,
	blue  => 0,
	alpha => 255
);

# Gets the width and height in pixels the text string would use up if
# drawn with the current font
my $text = "Perl 6";
my Int $tw = 0;
my Int $th = 0;
$tools.get_text_size($text, $tw, $th);

$tools.text_draw(
	x    => (10 - $tw/2).Int(),
	y    => (80 - $th/2).Int(),
	text => $text
);

# Frees the font list
$tools.free_font();

$tools.image_set_format("png");
unlink("images/test_font.png") if "images/test_font.png".IO ~~ :e;
$tools.save_image("images/test_font.png");

# Frees the image that is set as the current image in Imlib2's context. 
$tools.free_image();

exit();
