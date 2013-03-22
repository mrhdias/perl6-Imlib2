use v6;
use Test;

plan 11;

use Imlib2;

my $im = Imlib2.new();
my $raw_image = $im.create_image(200, 200);
$raw_image.context_set();

lives_ok { $im.image_flip(FLIP_HORIZONTAL); }, 'imlib_image_flip_horizontal';
lives_ok { $im.image_flip(FLIP_VERTICAL); }, 'imlib_image_flip_vertical';
lives_ok { $im.image_flip(FLIP_DIAGONAL); }, 'imlib_image_flip_diagonal';

lives_ok { $im.image_orientate(ROTATE_90_DEGREES); }, 'image_orientate - rotate 90 degrees';
lives_ok { $im.image_orientate(ROTATE_180_DEGREES); }, 'image_orientate - rotate 180 degrees';
lives_ok { $im.image_orientate(ROTATE_270_DEGREES); }, 'image_orientate - rotate 270 degrees';

lives_ok { $im.image_blur(12); }, 'image_blur is set to 12';

lives_ok { $im.image_sharpen(20); }, 'image_sharpen is set to 20';

lives_ok { $im.image_tile(); }, 'image_tile';
lives_ok { $im.image_tile(TILE_HORIZONTAL); }, 'imlib_image_tile_horizontal';
lives_ok { $im.image_tile(TILE_VERTICAL); }, 'imlib_image_tile_vertical';

$im.free_image();

done;
