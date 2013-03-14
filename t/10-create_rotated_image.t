use v6;
use Test;

plan 2;

use Imlib2;

my $tools = Imlib2.new();
my $raw_image = $tools.create_image(100, 200);
$raw_image.context_set_image();

my $rotated_image = $tools.create_rotated_image(45.0);
isa_ok $rotated_image, Imlib2::Image;
ok $rotated_image, 'create_rotated_image';

$rotated_image.context_set_image();
$tools.free_image();

$raw_image.context_set_image();
$tools.free_image();

done;
