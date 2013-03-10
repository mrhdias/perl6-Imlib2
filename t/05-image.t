use v6;
use Test;

plan 19;

use Imlib2;

my $tools = Imlib2.new();
isa_ok $tools, Imlib2;

my $rawimage = $tools.create_image(100, 100);
isa_ok $rawimage, Imlib2::Image, 'create_image';
ok $rawimage, 'create_image';

lives_ok { $rawimage.context_set_image(); }, 'context_set_image';

is $tools.image_get_height(), 100, 'image_get_height';
is $tools.image_get_width(), 100, 'image_get_width';

lives_ok {
	$tools.image_fill_rectangle(
		x      => 0,
		y      => 0,
		width  => 100,
		height => 100
	);
}, 'image_fill_rectangle';

lives_ok {
	$tools.image_draw_rectangle(
		x      => 10,
		y      => 10,
		width  => 100 - 20,
		height => 100 - 20
	);
}, 'image_draw_rectangle';

lives_ok { $tools.image_set_format("png"); }, 'image_set_format';

unlink("test.png") if "test.png".IO ~~ :e;
lives_ok { $tools.save_image("test.png"); }, 'save_image';
lives_ok { $tools.free_image(); }, 'free_image';

my $loadedimage = $tools.load_image("test.png");
isa_ok $loadedimage, Imlib2::Image;
ok $loadedimage, 'load_image';
$loadedimage.context_set_image();

my $clone = $tools.clone_image();
isa_ok $clone, Imlib2::Image;
ok $clone, 'clone_image';
$clone.context_set_image();
$tools.free_image();

$loadedimage.context_set_image();
my $cropped = $tools.create_cropped_image(
	x      => 0,
	y      => 0,
	width  => 50,
	height => 50);
isa_ok $cropped, Imlib2::Image;
ok $cropped, 'create_cropped_image';
$cropped.context_set_image();
$tools.free_image();

$loadedimage.context_set_image();
my $cropped_scaled = $tools.create_cropped_scaled_image(
	source_x           => 0,
	source_y           => 0,
	source_width       => 100,
	source_height      => 100,
	destination_width  => 50,
	destination_height => 50);
isa_ok $cropped_scaled, Imlib2::Image;
ok $cropped_scaled, 'create_cropped_scaled_image';
$cropped_scaled.context_set_image();
$tools.free_image();

$loadedimage.context_set_image();
$tools.free_image();
unlink("test.png") if "test.png".IO ~~ :e;

done;
