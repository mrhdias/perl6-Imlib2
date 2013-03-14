use v6;
use Test;

plan 2;

use Imlib2;

my $tools = Imlib2.new();
my $raw_image = $tools.create_image(100, 200);
$raw_image.context_set_image();

my $cropped_image = $tools.create_cropped_image(
	x      => 0,
	y      => 0,
	width  => 40,
	height => 80);

isa_ok $cropped_image, Imlib2::Image;
ok $cropped_image, 'create_cropped_image';

$cropped_image.context_set_image();
$tools.free_image();

$raw_image.context_set_image();
$tools.free_image();

done;
