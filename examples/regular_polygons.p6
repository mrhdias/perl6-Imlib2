#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $number_of_sides = 3;
my $radius = 100;
my $xc = 100;
my $yc = 100;

my $im = Imlib2.new();
my $newimage = $im.create_image(200, 200);
exit() unless $newimage;

$newimage.context_set();

$im.image_draw_rectangle(
	location => (0, 0),
	size     => (200, 200),
	fill     => True);

my $polygon = $im.polygon_new();
exit() unless $polygon;

$polygon.add_point(
	($xc + $radius * cos(0)).Int,
	($yc + $radius * sin(0)).Int);

loop (my $i = 1; $i < $number_of_sides; $i++) {
	$polygon.add_point(
		($xc + $radius * cos($i * 2 * pi / $number_of_sides)).Int,
		($yc + $radius * sin($i * 2 * pi / $number_of_sides)).Int);
}

$im.context_set_color(0xff0000ff);
$im.image_draw_polygon($polygon);

$polygon.free();

$im.image_set_format("png");
unlink("images/test_regular_polygon.png") if "images/test_regular_polygon.png".IO ~~ :e;
$im.save_image("images/test_regular_polygon.png");
$im.free_image();

exit();
