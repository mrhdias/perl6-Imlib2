use v6;
use Test;

plan 30;

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

lives_ok {
	$tools.context_set_color(red => 127, green => 0, blue => 255, alpha => 255);
}, 'context_set_color with named arguments';

lives_ok { $tools.context_set_color("#FFFFFF", 255); }, 'context_set_color with hexadecimal color code';

done;
