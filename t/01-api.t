use v6;
use Test;

plan 26;

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

my $color_modifier = $tools.create_color_modifier();
isa_ok $color_modifier, Imlib2::ColorModifier;
ok $color_modifier, 'create_color_modifier';

lives_ok { $color_modifier.context_set_color_modifier(); }, 'context_set_color_modifier';

my $get_color_modifier = $tools.context_get_color_modifier();
isa_ok $get_color_modifier, Imlib2::ColorModifier;
ok $get_color_modifier, 'context_get_color_modifier';

lives_ok { $tools.free_color_modifier(); }, 'free_color_modifier';

done;
