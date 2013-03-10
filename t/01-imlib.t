use v6;
use Test;

plan 36;

use Imlib2;

my $tools = Imlib2.new();
isa_ok $tools, Imlib2;

lives_ok {
	$tools.context_set_cliprect(
		x => 0,
		y => 0,
		width => 100,
		height => 100);
}, 'context_set_cliprect';

lives_ok { $tools.context_set_dither_mask(True); }, 'context_set_dither_mask is set to True';
is $tools.context_get_dither_mask(), True, 'context_get_dither_mask returns True';

lives_ok { $tools.context_set_dither_mask(False); }, 'context_set_dither_mask is set to False';
is $tools.context_get_dither_mask(), False, 'context_get_dither_mask returns False';

lives_ok { $tools.context_set_mask_alpha_threshold(150); }, 'context_set_mask_alpha_threshold is set to 150';
is $tools.context_get_mask_alpha_threshold(), 150, 'context_get_mask_alpha_threshold returns 150';

lives_ok { $tools.context_set_anti_alias(True); }, 'context_set_anti_alias is set to True';
is $tools.context_get_anti_alias(), True, 'context_get_anti_alias returns True';

lives_ok { $tools.context_set_anti_alias(False); }, 'context_set_anti_alias is set to False';
is $tools.context_get_anti_alias(), False, 'context_get_anti_alias returns False';

lives_ok { $tools.context_set_dither(True); }, 'context_set_dither is set to True';
is $tools.context_get_dither(), True, 'context_get_dither returns True';

lives_ok { $tools.context_set_dither(False); }, 'context_set_dither is set to False';
is $tools.context_get_dither(), False, 'context_get_dither returns False';

lives_ok { $tools.context_set_blend(True); }, 'context_set_blend is set to True';
is $tools.context_get_blend(), True, 'context_get_blend returns True';

lives_ok { $tools.context_set_blend(False); }, 'context_set_blend is set to False';
is $tools.context_get_blend(), False, 'context_get_blend returns False';

lives_ok { $tools.context_set_operation(OP_COPY); }, 'context_set_operation is set to OP_COPY mode';
is $tools.context_get_operation(), OP_COPY, 'context_get_operation returns OP_COPY mode';

lives_ok { $tools.context_set_operation(OP_ADD); }, 'context_set_operation is set to OP_ADD mode';
is $tools.context_get_operation(), OP_ADD, 'context_get_operation returns OP_ADD mode';

lives_ok { $tools.context_set_operation(OP_SUBTRACT); }, 'context_set_operation is set to OP_SUBTRACT mode';
is $tools.context_get_operation(), OP_SUBTRACT, 'context_get_operation returns OP_SUBTRACT mode';

lives_ok { $tools.context_set_operation(OP_RESHADE); }, 'context_set_operation is set to OP_RESHADE mode';
is $tools.context_get_operation(), OP_RESHADE, 'context_get_operation returns OP_RESHADE mode';

lives_ok { $tools.context_set_color("#FFFFFF", 255); }, 'context_set_color with hexadecimal color code';

lives_ok {
	$tools.context_set_color(red => 10, green => 127, blue => 200, alpha => 255);
}, 'context_set_color with named arguments';

my %color_channels;
lives_ok { $tools.context_get_color(%color_channels); }, 'context_get_color';
is %color_channels{'red'}, 10, 'the red channel of the current color is 10';
is %color_channels{'green'}, 127, 'the green channel of the current color is 127';
is %color_channels{'blue'}, 200, 'the blue channel of the current color is 200';
is %color_channels{'alpha'}, 255, 'the alpha channel of the current color is 255';
is %color_channels{'hexcode'}, "#0a7fc8", 'the hexacode of the current color is #0a7fc8';

done;
