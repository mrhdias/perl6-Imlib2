use v6;
use Test;

plan 45;

use Imlib2;

my $tools = Imlib2.new();

my $test_file = "test.png";
my $test_error_file = "test.jpg";

my $rawimage = $tools.create_image(100, 200);
isa_ok $rawimage, Imlib2::Image;
ok $rawimage, 'create_image';

lives_ok { $rawimage.context_set_image(); }, 'context_set_image';

is $tools.image_get_width(), 100, 'image_get_width - the image width is 100 pixels';
is $tools.image_get_height(), 200, 'image_get_height - the image height is 200 pixels';

my %size = $tools.image_get_size();
is %size{'width'}, 100, 'image_get_size - the image width is 100 pixels';
is %size{'height'}, 200, 'image_get_size - the image height is 200 pixels';

my $border = $tools.new_border();
isa_ok $border, Imlib2::Border;
ok $border, 'new_border';

lives_ok { $border.left(1); }, 'set left border to 1';
lives_ok { $border.right(2); }, 'set right border to 2';
lives_ok { $border.top(3); }, 'set top border to 3';
lives_ok { $border.bottom(4); }, 'set bottom border to 4';

lives_ok { $tools.image_set_border($border); }, 'image_set_border';
lives_ok { $tools.image_get_border($border); }, 'image_get_border';

is $border.left, 1, 'left border returns 1';
is $border.right, 2, 'right border returns 2';
is $border.top, 3, 'top border returns 3';
is $border.bottom, 4, 'bottom border returns 4';

my Bool $alpha = $tools.image_has_alpha();
is $alpha, False, 'image_has_alpha returns False';

lives_ok { $tools.image_set_has_alpha(True); }, 'image_set_has_alpha - set has alpha to True';
$alpha = $tools.image_has_alpha();
is $alpha, True, 'image_has_alpha returns True';

my $get_rawimage = $tools.context_get_image();
isa_ok $get_rawimage, Imlib2::Image;
ok $get_rawimage, 'context_get_image';

lives_ok { $tools.image_set_format("png"); }, 'image_set_format';
is $tools.image_format(), "png", 'image_format returns PNG format';

unlink($test_file) if "test.png".IO ~~ :e;
lives_ok { $tools.save_image($test_file); }, 'save_image';
lives_ok { $tools.free_image(); }, 'free_image';

my $loadedimage = $tools.load_image($test_file);
isa_ok $loadedimage, Imlib2::Image;
ok $loadedimage, 'load_image';
$loadedimage.context_set_image();

lives_ok { $tools.image_set_changes_on_disk(); }, 'image_set_changes_on_disk';

is $tools.image_get_filename(), $test_file, 'image_get_filename';

lives_ok { $tools.free_image(True); }, 'imlib_free_image_and_decache';

my $image_if_ct = $tools.load_image(filename => $test_file, immediately => False, cache => True);
isa_ok $image_if_ct, Imlib2::Image;
ok $image_if_ct, 'imlib_load_image with named arguments';
$image_if_ct.context_set_image();
$tools.free_image();

my $image_it_ct = $tools.load_image(filename => $test_file, immediately => True, cache => True);
isa_ok $image_it_ct, Imlib2::Image;
ok $image_it_ct, 'imlib_load_image_immediately';
$image_it_ct.context_set_image();
$tools.free_image();

my $image_if_cf = $tools.load_image(filename => $test_file, immediately => False, cache => False);
isa_ok $image_if_cf, Imlib2::Image;
ok $image_if_cf, 'imlib_load_image_without_cache';
$image_if_cf.context_set_image();
$tools.free_image();

my $image_it_cf = $tools.load_image(filename => $test_file, immediately => True, cache => False);
isa_ok $image_it_cf, Imlib2::Image;
ok $image_it_cf, 'imlib_load_image_immediately_without_cache';
$image_it_cf.context_set_image();
$tools.free_image();

my LoadError $error;
my $error_image = $tools.load_image($test_file, $error);
isa_ok $error_image, Imlib2::Image;
ok $error_image, 'imlib_load_image_with_error_return';
is $error, LOAD_ERROR_NONE, 'imlib_load_image_with_error_return LOAD_ERROR_NONE';
$error_image.context_set_image();
$tools.free_image();

my $fail_image = $tools.load_image($test_error_file, $error);
is $error, LOAD_ERROR_FILE_DOES_NOT_EXIST, 'imlib_load_image_with_error_return LOAD_ERROR_FILE_DOES_NOT_EXIST';
$tools.free_image() if $tools.context_get_image();

unlink($test_file) if $test_file.IO ~~ :e;

done;


#lives_ok {
#	$tools.image_fill_rectangle(
#		x      => 0,
#		y      => 0,
#		width  => 100,
#		height => 100
#	);
#}, 'image_fill_rectangle';

#lives_ok {
#	$tools.image_draw_rectangle(
#		x      => 10,
#		y      => 10,
#		width  => 100 - 20,
#		height => 100 - 20
#	);
#}, 'image_draw_rectangle';

#unlink("test.png") if "test.png".IO ~~ :e;
#lives_ok { $tools.save_image("test.png"); }, 'save_image';
#lives_ok { $tools.free_image(); }, 'free_image';

#my $clone = $tools.clone_image();
#isa_ok $clone, Imlib2::Image;
#ok $clone, 'clone_image';
#$clone.context_set_image();
#$tools.free_image();

#$loadedimage.context_set_image();
#my $cropped = $tools.create_cropped_image(
#	x      => 0,
#	y      => 0,
#	width  => 50,
#	height => 50);
#isa_ok $cropped, Imlib2::Image;
#ok $cropped, 'create_cropped_image';
#$cropped.context_set_image();
#$tools.free_image();

#$loadedimage.context_set_image();
#my $cropped_scaled = $tools.create_cropped_scaled_image(
#	source_x           => 0,
#	source_y           => 0,
#	source_width       => 100,
#	source_height      => 100,
#	destination_width  => 50,
#	destination_height => 50);
#isa_ok $cropped_scaled, Imlib2::Image;
#ok $cropped_scaled, 'create_cropped_scaled_image';
#$cropped_scaled.context_set_image();
#$tools.free_image();

