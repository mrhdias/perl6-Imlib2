use v6;
use Test;

plan 21;

use Imlib2;

my $tools = Imlib2.new();

lives_ok { $tools.add_path_to_font_path("t/fonts");}, 'add_path_to_font_path is set with "t/fonts" path';
lives_ok { $tools.font_cache_size(512 * 1024);}, 'font_cache_size is set to 512 * 1024 bytes';

is $tools.font_cache_size(), 512 * 1024, 'font_cache_size returns 512 * 1024 bytes';

my $corefont = $tools.load_font("comic", 36);
isa_ok $corefont, Imlib2::Font;
ok $corefont, 'load_font';

lives_ok { $corefont.context_set_font(); }, 'context_set_font';

my $get_font = $tools.context_get_font();
isa_ok $get_font, Imlib2::Font;
ok $get_font, 'context_get_font';

lives_ok { $tools.context_set_direction(TEXT_TO_RIGHT); }, 'context_set_direction is set to TEXT_TO_RIGHT';
is $tools.context_get_direction(), TEXT_TO_RIGHT, 'context_get_direction returns TEXT_TO_RIGHT';

lives_ok { $tools.context_set_direction(TEXT_TO_LEFT); }, 'context_set_direction is set to TEXT_TO_LEFT';
is $tools.context_get_direction(), TEXT_TO_LEFT, 'context_get_direction returns TEXT_TO_LEFT';

lives_ok { $tools.context_set_direction(TEXT_TO_DOWN); }, 'context_set_direction is set to TEXT_TO_DOWN';
is $tools.context_get_direction(), TEXT_TO_DOWN, 'context_get_direction returns TEXT_TO_DOWN';

lives_ok { $tools.context_set_direction(TEXT_TO_UP); }, 'context_set_direction is set to TEXT_TO_UP';
is $tools.context_get_direction(), TEXT_TO_UP, 'context_get_direction returns TEXT_TO_UP';

lives_ok { $tools.context_set_direction(TEXT_TO_ANGLE); }, 'context_set_direction is set to TEXT_TO_ANGLE';
is $tools.context_get_direction(), TEXT_TO_ANGLE, 'context_get_direction returns TEXT_TO_ANGLE';

lives_ok { $tools.context_set_angle(-45.0); }, 'context_set_angle is set to -45.0';
is $tools.context_get_angle(), -45.0, 'context_get_angle returns -45.0';

lives_ok {
	$tools.free_font() if $get_font;
}, 'free_font';

done;
