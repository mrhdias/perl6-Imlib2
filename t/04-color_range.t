use v6;
use Test;

plan 6;

use Imlib2;

my $tools = Imlib2.new();

my $color_range = $tools.create_color_range();
isa_ok $color_range, Imlib2::ColorRange;
ok $color_range, 'create_color_range';

lives_ok { $color_range.context_set_color_range(); }, 'context_set_color_range';

my $get_color_range = $tools.context_get_color_range();
isa_ok $get_color_range, Imlib2::ColorRange;
ok $get_color_range, 'context_get_color_range';

lives_ok { $tools.free_color_range(); }, 'free_color_range';

done;
