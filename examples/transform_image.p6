#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use Imlib2;

my $tools = Imlib2.new();
my $loaded_image = $tools.load_image("images/camelia-logo.jpg");
exit() unless $loaded_image;
$loaded_image.context_set_image();

$tools.image_set_format("png");

$tools.image_flip(HORIZONTAL);

$tools.image_orientate(ROTATE_90_DEGREE);

unlink("images/test_transform.png") if "images/test_transform.png".IO ~~ :e;
$tools.save_image("images/test_transform.png");

my $rotated_image = $tools.create_rotated_image(-45.0);
$rotated_image.context_set_image();

unlink("images/test_rotated.png") if "images/test_rotated.png".IO ~~ :e;
$tools.save_image("images/test_rotated.png");

$tools.free_image();

$loaded_image.context_set_image();
$tools.free_image();

exit();
