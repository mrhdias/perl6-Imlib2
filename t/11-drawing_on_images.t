use v6;
use Test;

plan 6;

use Imlib2;

my $im = Imlib2.new();
my $raw_image = $im.create_image(200, 200);
$raw_image.context_set();

$im.context_set_color(0xffffffff);

lives_ok {
	$im.image_draw_line(
		start => (10, 10),
		end   => (190, 190),
		update => False);
}, 'image_draw_line with update option set to False';

my $updates = $im.image_draw_line(
	start => (10, 10),
	end   => (190, 190),
	update => True);
isa_ok $updates, Imlib2::Updates;
ok $updates, 'image_draw_line with update option set to True';

lives_ok {
	$im.image_draw_rectangle(
		location => (0, 0),
		size     => (200, 200),
		fill     => True);
}, 'image_draw_rectangle - fill is set to True';

$im.context_set_color(0x000000ff);
lives_ok {
	$im.image_draw_rectangle(
		location => (0, 0),
		size     => (200, 200));
}, 'image_draw_rectangle - fill is set to False';

lives_ok {
	$im.image_draw_rectangle(
		size     => (200, 200));
}, 'image_draw_rectangle - without location';

$im.free_image();

done;
