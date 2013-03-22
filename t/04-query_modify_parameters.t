use v6;
use Test;

plan 30;

use Imlib2;

my $test_file = "test.png";

my $im = Imlib2.new();

my $rawimage = $im.create_image(100, 200);
$rawimage.context_set();

lives_ok { $im.image_set_format("png"); }, 'image_set_format';
is $im.image_get_format(), "png", 'image_format returns PNG format';

unlink($test_file) if $test_file.IO ~~ :e;
$im.save_image($test_file);
$im.free_image();

my $loadedimage = $im.load_image($test_file);
$loadedimage.context_set();

is $im.image_get_width(), 100, 'image_get_width - the image width is 100 pixels';
is $im.image_get_height(), 200, 'image_get_height - the image height is 200 pixels';

my ($width, $height) = $im.image_get_size();
is $width, 100, 'image_get_size - the image width is 100 pixels';
is $height, 200, 'image_get_size - the image height is 200 pixels';

is $im.image_get_filename(), $test_file, 'image_get_filename';

lives_ok { $im.image_set_has_alpha(True); }, 'image_set_has_alpha - set has alpha to True';
is $im.image_has_alpha(), True, 'image_has_alpha returns True';
lives_ok { $im.image_set_has_alpha(False); }, 'image_set_has_alpha - set has alpha to False';
is $im.image_has_alpha(), False, 'image_has_alpha returns False';

lives_ok { $im.image_set_changes_on_disk(); }, 'image_set_changes_on_disk';

my $border = $im.new_border();
isa_ok $border, Imlib2::Border;
ok $border, 'new_border';

lives_ok { $border.left(1); }, 'set left border to 1';
lives_ok { $border.right(2); }, 'set right border to 2';
lives_ok { $border.top(3); }, 'set top border to 3';
lives_ok { $border.bottom(4); }, 'set bottom border to 4';

lives_ok { $im.image_set_border($border); }, 'image_set_border';
lives_ok { $im.image_get_border($border); }, 'image_get_border';

is $border.left, 1, 'left border returns 1';
is $border.right, 2, 'right border returns 2';
is $border.top, 3, 'top border returns 3';
is $border.bottom, 4, 'bottom border returns 4';

lives_ok { $im.image_set_irrelevant_format(True); }, 'image_set_irrelevant_format is set to True';
lives_ok { $im.image_set_irrelevant_format(False); }, 'image_set_irrelevant_format is set to False';
lives_ok { $im.image_set_irrelevant_border(True); }, 'image_set_irrelevant_border is set to True';
lives_ok { $im.image_set_irrelevant_border(False); }, 'image_set_irrelevant_border is set to False';
lives_ok { $im.image_set_irrelevant_alpha(True); }, 'image_set_irrelevant_alpha is set to True';
lives_ok { $im.image_set_irrelevant_alpha(False); }, 'image_set_irrelevant_alpha is set to False';

$im.free_image();
unlink($test_file) if "test.png".IO ~~ :e;

done;
