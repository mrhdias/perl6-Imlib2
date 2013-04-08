use v6;
use Test;

plan 72;

use Imlib2;

my $im = Imlib2.new();

lives_ok { $im.context_set_dither_mask(True); }, 'context_set_dither_mask is set to True';
is $im.context_get_dither_mask(), True, 'context_get_dither_mask returns True';
lives_ok { $im.context_set_dither_mask(False); }, 'context_set_dither_mask is set to False';
is $im.context_get_dither_mask(), False, 'context_get_dither_mask returns False';

lives_ok { $im.context_set_anti_alias(True); }, 'context_set_anti_alias is set to True';
is $im.context_get_anti_alias(), True, 'context_get_anti_alias returns True';
lives_ok { $im.context_set_anti_alias(False); }, 'context_set_anti_alias is set to False';
is $im.context_get_anti_alias(), False, 'context_get_anti_alias returns False';

lives_ok { $im.context_set_mask_alpha_threshold(150); }, 'context_set_mask_alpha_threshold is set to 150';
is $im.context_get_mask_alpha_threshold(), 150, 'context_get_mask_alpha_threshold returns 150';

lives_ok { $im.context_set_dither(True); }, 'context_set_dither is set to True';
is $im.context_get_dither(), True, 'context_get_dither returns True';
lives_ok { $im.context_set_dither(False); }, 'context_set_dither is set to False';
is $im.context_get_dither(), False, 'context_get_dither returns False';

lives_ok { $im.context_set_blend(True); }, 'context_set_blend is set to True';
is $im.context_get_blend(), True, 'context_get_blend returns True';
lives_ok { $im.context_set_blend(False); }, 'context_set_blend is set to False';
is $im.context_get_blend(), False, 'context_get_blend returns False';

my $color_modifier = $im.create_color_modifier();
lives_ok { $color_modifier.context_set(); }, 'context_set color_modifier';
my $get_color_modifier = $im.context_get_color_modifier();
isa_ok $get_color_modifier, Imlib2::ColorModifier;
ok $get_color_modifier, 'context_get_color_modifier';
$im.free_color_modifier();

lives_ok { $im.context_set_operation(IMLIB_OP_COPY); }, 'context_set_operation is set to IMLIB_OP_COPY mode';
is $im.context_get_operation(), IMLIB_OP_COPY, 'context_get_operation returns IMLIB_OP_COPY mode';
lives_ok { $im.context_set_operation(IMLIB_OP_ADD); }, 'context_set_operation is set to IMLIB_OP_ADD mode';
is $im.context_get_operation(), IMLIB_OP_ADD, 'context_get_operation returns IMLIB_OP_ADD mode';
lives_ok { $im.context_set_operation(IMLIB_OP_SUBTRACT); }, 'context_set_operation is set to IMLIB_OP_SUBTRACT mode';
is $im.context_get_operation(), IMLIB_OP_SUBTRACT, 'context_get_operation returns IMLIB_OP_SUBTRACT mode';
lives_ok { $im.context_set_operation(IMLIB_OP_RESHADE); }, 'context_set_operation is set to IMLIB_OP_RESHADE mode';
is $im.context_get_operation(), IMLIB_OP_RESHADE, 'context_get_operation returns IMLIB_OP_RESHADE mode';

# context_set_font -> xx-fonts_and_text.t
# context_get_font -> xx-fonts_and_text.t

lives_ok { $im.context_set_direction(IMLIB_TEXT_TO_RIGHT); }, 'context_set_direction is set to IMLIB_TEXT_TO_RIGHT';
is $im.context_get_direction(), IMLIB_TEXT_TO_RIGHT, 'context_get_direction returns IMLIB_TEXT_TO_RIGHT';
lives_ok { $im.context_set_direction(IMLIB_TEXT_TO_LEFT); }, 'context_set_direction is set to IMLIB_TEXT_TO_LEFT';
is $im.context_get_direction(), IMLIB_TEXT_TO_LEFT, 'context_get_direction returns IMLIB_TEXT_TO_LEFT';
lives_ok { $im.context_set_direction(TEXT_TO_DOWN); }, 'context_set_direction is set to IMLIB_TEXT_TO_DOWN';
is $im.context_get_direction(), IMLIB_TEXT_TO_DOWN, 'context_get_direction returns IMLIB_TEXT_TO_DOWN';
lives_ok { $im.context_set_direction(IMLIB_TEXT_TO_UP); }, 'context_set_direction is set to IMLIB_TEXT_TO_UP';
is $im.context_get_direction(), IMLIB_TEXT_TO_UP, 'context_get_direction returns IMLIB_TEXT_TO_UP';
lives_ok { $im.context_set_direction(IMLIB_TEXT_TO_ANGLE); }, 'context_set_direction is set to IMLIB_TEXT_TO_ANGLE';
is $im.context_get_direction(), IMLIB_TEXT_TO_ANGLE, 'context_get_direction returns IMLIB_TEXT_TO_ANGLE';

lives_ok { $im.context_set_angle(-45.0); }, 'context_set_angle is set to -45.0';
is $im.context_get_angle(), -45.0, 'context_get_angle returns -45.0';

lives_ok {
	$im.context_set_color("#ff0000");
}, 'context_set_color with hexadecimal color string rgb';
lives_ok {
	$im.context_set_color("#ff00ffff");
}, 'context_set_color with hexadecimal color string rgba';
lives_ok {
	$im.context_set_color(0xffffffff);
}, 'context_set_color with hexadecimal color number';
lives_ok {
	$im.context_set_color(red => 10, green => 127, blue => 200, alpha => 255);
}, 'context_set_color - rgba colar space with named arguments';
my %color_channels;
lives_ok { $im.context_get_color(%color_channels); }, 'context_get_color';
is %color_channels{'red'}, 10, 'the red channel of the current color is 10';
is %color_channels{'green'}, 127, 'the green channel of the current color is 127';
is %color_channels{'blue'}, 200, 'the blue channel of the current color is 200';
is %color_channels{'alpha'}, 255, 'the alpha channel of the current color is 255';
is %color_channels{'hexcode'}, "#0a7fc8", 'the hexacode of the current color is #0a7fc8';

#my %cc = $im.context_get_color();
#say %cc{'red'};
#say %cc{'green'};
#say %cc{'blue'};
#say %cc{'alpha'};
#say %cc{'hexcode'};

lives_ok {
	$im.context_set_color(hue => 180, saturation => 50, value => 75, alpha => 127);
}, 'context_set_color - hsva color space';

#my %hsva_channels;
#$im.context_get_color_hsva(%hsva_channels);
#say "Hue: " ~ %hsva_channels{'hue'};
#say "Saturation: " ~ %hsva_channels{'saturation'};
#say "Value: " ~ %hsva_channels{'value'};
#say "Alpha: " ~ %hsva_channels{'alpha'};

lives_ok {
	$im.context_set_color(hue => 180, lightness => 50, saturation => 75, alpha => 127);
}, 'context_set_color - hlsa color space';

#my %hlsa_channels;
#$im.context_get_color_hlsa(%hlsa_channels);
#say "Hue: " ~ %hlsa_channels{'hue'};
#say "Lightness: " ~ %hlsa_channels{'lightness'};
#say "Saturation: " ~ %hlsa_channels{'saturation'};
#say "Alpha: " ~ %hlsa_channels{'alpha'};

lives_ok {
	$im.context_set_color(cyan => 25, magenta => 125, yellow => 200, alpha => 255);
}, 'context_set_color - cmya color space';

my %cmya_channels;
lives_ok { $im.context_get_color_cmya(%cmya_channels); }, 'context_get_color_cmya';
is %cmya_channels{'cyan'}, 25, 'the cyan channel of the current color is 25';
is %cmya_channels{'magenta'}, 125, 'the magenta channel of the current color is 25';
is %cmya_channels{'yellow'}, 200, 'the yellow channel of the current color is 200';
is %cmya_channels{'alpha'}, 255, 'the alpha channel of the current color is 255';

# context_set_color_range -> xx-color_range.t
# context_get_color_range -> xx-color_range.t

my $rawimage = $im.create_image(100, 200);
lives_ok { $rawimage.context_set(); }, 'context_set image';
my $get_rawimage = $im.context_get_image();
isa_ok $get_rawimage, Imlib2::Image;
ok $get_rawimage, 'context_get_image';

lives_ok {
	$im.context_set_cliprect(x => 10, y => 25, width => 100, height => 125);
}, 'context_set_cliprect';

my %cliprect;
lives_ok { $im.context_get_cliprect(%cliprect); }, 'context_get_cliprect';
is %cliprect{'x'}, 10, 'the top left x coordinate of the rectangle is 10';
is %cliprect{'y'}, 25, 'the top left y coordinate of the rectangle is 25';
is %cliprect{'width'}, 100, 'the width of the rectangle is 100';
is %cliprect{'height'}, 125, 'the height of the rectangle is 125';

lives_ok { $im.set_cache_size(2048 * 1024); }, 'set_cache_size';
is $im.get_cache_size(), 2048 * 1024, 'the cache size is set to 2048 * 1024 bytes';

lives_ok { $im.set_color_usage(256); }, 'set_color_usage';
is $im.get_color_usage(), 256, 'the current number of colors is 256';

$im.free_image();

done;
