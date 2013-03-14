use v6;
use Test;

plan 4;

use Imlib2;

my $tools = Imlib2.new();
my $raw_image = $tools.create_image(200, 200);
$raw_image.context_set_image();

lives_ok { $tools.image_flip(HORIZONTAL); }, 'imlib_image_flip_horizontal';
lives_ok { $tools.image_flip(VERTICAL); }, 'imlib_image_flip_vertical';
lives_ok { $tools.image_flip(DIAGONAL); }, 'imlib_image_flip_diagonal';

lives_ok { $tools.image_orientate(ROTATE_90_DEGREE); }, 'image_orientate - rotate 90 degree';

$raw_image.context_set_image();
$tools.free_image();

done;
