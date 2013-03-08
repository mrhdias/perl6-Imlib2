use v6;
use Test;

plan 6;

use Imlib2;

my $tools = Imlib2.new();
my $rawimage = $tools.create_image(100, 100);
$rawimage.context_set_image();

my $polygon = $tools.polygon_new();
isa_ok $polygon, Imlib2::Polygon;

lives_ok { $polygon.polygon_add_points(10, 10); }, 'polygon_add_points';

is $polygon.polygon_contains_point(10, 10), 1, 'polygon_contains_point';

lives_ok { $polygon.polygon_free(); }, 'polygon_free';
lives_ok { $tools.image_draw_polygon($polygon); }, 'image_draw_polygon';
lives_ok { $tools.image_fill_polygon($polygon); }, 'image_fill_polygon';

$tools.free_image();

done;
