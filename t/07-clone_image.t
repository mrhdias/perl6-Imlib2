use v6;
use Test;

plan 2;

use Imlib2;

my $tools = Imlib2.new();
my $raw_image = $tools.create_image(100, 200);
$raw_image.context_set_image();

my $cloned_image = $tools.clone_image();
isa_ok $cloned_image, Imlib2::Image;
ok $cloned_image, 'clone_image';

$cloned_image.context_set_image();
$tools.free_image();

$raw_image.context_set_image();
$tools.free_image();

done;
