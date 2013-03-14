use v6;
use Test;

plan 2;

use Imlib2;

my $tools = Imlib2.new();
my $raw_image = $tools.create_image(200, 200);
$raw_image.context_set_image();

my $cropped_scaled_image = $tools.create_cropped_scaled_image(
	source_x           => 0,
	source_y           => 0,
	source_width       => 100,
	source_height      => 100,
	destination_width  => 50,
	destination_height => 50);
isa_ok $cropped_scaled_image, Imlib2::Image;
ok $cropped_scaled_image, 'create_cropped_scaled_image';

$cropped_scaled_image.context_set_image();
$tools.free_image();

$raw_image.context_set_image();
$tools.free_image();

done;
