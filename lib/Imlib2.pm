use NativeCall;

sub LIB {
	given $*VM{'config'}{'load_ext'} {
		when '.so' { return 'libImlib2.so' }		# Linux
		when '.bundle' { return 'libImlib2.dylib' }	# Mac OS
		default { return 'libImlib2' }
	}
}

enum TextDirection <
	TEXT_TO_RIGHT
	TEXT_TO_LEFT
	TEXT_TO_DOWN
	TEXT_TO_UP
	TEXT_TO_ANGLE>;

enum LoadError <
	LOAD_ERROR_NONE
	LOAD_ERROR_FILE_DOES_NOT_EXIST
	LOAD_ERROR_FILE_IS_DIRECTORY
	LOAD_ERROR_PERMISSION_DENIED_TO_READ
	LOAD_ERROR_NO_LOADER_FOR_FILE_FORMAT
	LOAD_ERROR_PATH_TOO_LONG
	LOAD_ERROR_PATH_COMPONENT_NON_EXISTANT
	LOAD_ERROR_PATH_COMPONENT_NOT_DIRECTORY
	LOAD_ERROR_PATH_POINTS_OUTSIDE_ADDRESS_SPACE
	LOAD_ERROR_TOO_MANY_SYMBOLIC_LINKS
	LOAD_ERROR_OUT_OF_MEMORY
	LOAD_ERROR_OUT_OF_FILE_DESCRIPTORS
	LOAD_ERROR_PERMISSION_DENIED_TO_WRITE
	LOAD_ERROR_OUT_OF_DISK_SPACE
	LOAD_ERROR_UNKNOWN>;

enum RotationMode <
	ROTATE_NONE
	ROTATE_90_DEGREES
	ROTATE_180_DEGREES
	ROTATE_270_DEGREES>;

enum OperationMode <OP_COPY OP_ADD OP_SUBTRACT OP_RESHADE>;
enum FlipMode <FLIP_HORIZONTAL FLIP_VERTICAL FLIP_DIAGONAL>;
enum TileMode <TILE_HORIZONTAL TILE_VERTICAL TILE_BOTH>;

class Imlib2::Border is repr('CStruct') {
	has int32 $.left_border;
	has int32 $.right_border;
	has int32 $.top_border;
	has int32 $.bottom_border;

#	method init(Int $l, Int $r, Int $t, Int $b) {
#		$!left_border = 0;
#		$!right_border = 0;
#		$!top_border = 0;
#		$!bottom_border = 0;
#	}
	
	multi method left(Int $l) { $!left_border = $l; }
	multi method right(Int $r) { $!right_border = $r; }
	multi method top(Int $t) { $!top_border = $t; }
	multi method bottom(Int $b) { $!bottom_border = $b; }	
	
	# this is a workaround, since NativeCall doesn't yet handle sized ints right
	multi method left() { return $!left_border; }
	multi method right() { return $!right_border; }
	multi method top() { return $!top_border; }
	multi method bottom() { return $!bottom_border; }
}

class Imlib2::Color is repr('CStruct') {
	has int32 $.alpha;
	has int32 $.red;
	has int32 $.green;
	has int32 $.blue;

	# this is a workaround, since NativeCall doesn't yet handle sized ints right
	method alpha() { return $!alpha; }
	method red() { return $!red; }
	method green() { return $!green; }
	method blue() { return $!blue; }
}

class Imlib2::ColorModifier is repr('CPointer') {
	sub imlib_context_set_color_modifier(Imlib2::ColorModifier)
		is native(LIB) { ... };

	method context_set() {
		imlib_context_set_color_modifier(self);
	}
}

class Imlib2::ColorRange is repr('CPointer') {
	sub imlib_context_set_color_range(Imlib2::ColorRange)
		is native(LIB) { ... };

	method context_set() {
		imlib_context_set_color_range(self);
	}	
}

class Imlib2::Font is repr('CPointer') {
	sub imlib_context_set_font(Imlib2::Font)
		is native(LIB) { ... };

	method context_set() {
		imlib_context_set_font(self);
	}
}

class Imlib2::Updates is repr('CPointer') {

}

class Imlib2::Image is repr('CPointer') {
	sub imlib_context_set_image(Imlib2::Image)
		is native(LIB) { ... };

	method context_set() {
		imlib_context_set_image(self);
	}
}

class Imlib2::Polygon is repr('CPointer') {
	sub imlib_polygon_add_point(Imlib2::Polygon, int32, int32)
		is native(LIB) { ... };
	
	sub imlib_polygon_contains_point(Imlib2::Polygon, int32, int32)
		returns int8 is native(LIB) { ... };

	sub imlib_polygon_get_bounds(Imlib2::Polygon $poly,
			CArray[int32] $px1, CArray[int32] $py1,
			CArray[int32] $px2, CArray[int32] $py2)
		is native(LIB) { ... };

	sub imlib_polygon_free(Imlib2::Polygon)
		is native(LIB) { ... };

	method add_point(Int $x, Int $y) {
		imlib_polygon_add_point(self, $x, $y);
	}

	method contains_point(Int $x, Int $y) returns Bool {
		return imlib_polygon_contains_point(self, $x, $y).Bool;
	}

	method get_bounds() {
		my @px1 := CArray[int32].new();
		my @py1 := CArray[int32].new();
		my @px2 := CArray[int32].new();
		my @py2 := CArray[int32].new();
		@px1[0] = @py1[0] = @px2[0] = @py2[0] = 0;
		
		imlib_polygon_get_bounds(self, @px1, @py1, @px2, @py2);

		return (@px1[0], @py1[0], @px2[0], @py2[0]);
	}

	method free() {
		imlib_polygon_free(self);
	}
}

class Imlib2 is repr('CPointer') {

	### context setting/getting ###

	sub imlib_context_set_dither_mask(int8)
		is native(LIB) { ... };

	sub imlib_context_get_dither_mask()
		returns int8 is native(LIB) { ... };

	sub imlib_context_set_anti_alias(int8)
		is native(LIB) { ... };

	sub imlib_context_get_anti_alias()
		returns int8 is native(LIB) { ... };

	sub imlib_context_set_mask_alpha_threshold(int32)
		is native(LIB) { ... };

	sub imlib_context_get_mask_alpha_threshold()
		returns int32 is native(LIB) { ... };

	sub imlib_context_set_dither(int8)
		is native(LIB) { ... };

	sub imlib_context_get_dither()
		returns int8 is native(LIB) { ... };

	sub imlib_context_set_blend(int8)
		is native(LIB) { ... };

	sub imlib_context_get_blend()
		returns int8 is native(LIB) { ... };

	sub imlib_context_get_color_modifier()
		returns Imlib2::ColorModifier is native(LIB) { ... };

	sub imlib_context_set_operation(int32)
		is native(LIB) { ... };

	sub imlib_context_get_operation()
		returns int32 is native(LIB) { ... };

	sub imlib_context_get_font()
		returns Imlib2::Font is native(LIB) { ... };

	sub imlib_context_set_direction(int32)
		is native(LIB) { ... };

	sub imlib_context_get_direction()
		returns int32 is native(LIB) { ... };

	sub imlib_context_set_angle(num)
		is native(LIB) { ... };

	sub imlib_context_get_angle()
		returns num is native(LIB) { ... };

	sub imlib_context_set_color(int32, int32, int32, int32)
		is native(LIB) { ... };

	sub imlib_context_get_color(CArray[int32] $red, CArray[int32] $green,
			CArray[int32] $blue, CArray[int32] $alpha)
		is native(LIB) { ... };

	sub imlib_context_get_imlib_color()
		returns Imlib2::Color is native(LIB) { ... };

	sub imlib_context_set_color_hsva(num32, num32, num32, int32)
		is native(LIB) { ... };

	sub imlib_context_get_color_hsva(CArray[num32] $hue, CArray[num32] $saturation,
			CArray[num32] $value, CArray[int32] $alpha)
		is native(LIB) { ... };

	sub imlib_context_set_color_hlsa(num32, num32, num32, int32)
		is native(LIB) { ... };

	sub imlib_context_get_color_hlsa(CArray[num32] $hue, CArray[num32] $lightness,
			CArray[num32] $saturation, CArray[int32] $alpha)
		is native(LIB) { ... };

	sub imlib_context_set_color_cmya(int32, int32, int32, int32)
		is native(LIB) { ... };

	sub imlib_context_get_color_cmya(CArray[int32] $cyan, CArray[int32] $magenta,
			CArray[int32] $yellow, CArray[int32] $alpha)
		is native(LIB) { ... };

	sub imlib_context_get_color_range()
		returns Imlib2::ColorRange is native(LIB) { ... };

	sub imlib_context_get_image()
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_context_set_cliprect(int32, int32, int32, int32)
		is native(LIB) { ... };

	sub imlib_context_get_cliprect(CArray[int32] $x, CArray[int32] $y,
			CArray[int32] $w, CArray[int32] $h)
		is native(LIB) { ... };

	sub imlib_set_cache_size(int32)
		is native(LIB) { ... };

	sub imlib_get_cache_size()
		returns int32 is native(LIB) { ... };

	sub imlib_set_color_usage(int32)
		is native(LIB) { ... };

	sub imlib_get_color_usage()
		returns int32 is native(LIB) { ... };

	### loading functions ###

	sub imlib_load_image(Str)
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_load_image_immediately(Str)
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_load_image_without_cache(Str)
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_load_image_immediately_without_cache(Str)
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_load_image_with_error_return(Str $filename, CArray[int32] $error_return)
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_free_image()
		is native(LIB) { ... };

	sub imlib_free_image_and_decache()
		is native(LIB) { ... };

	sub imlib_flush_loaders()
		is native(LIB) { ... };

	### query/modify image parameters ###

	sub imlib_image_get_width()
		returns int32 is native(LIB) { ... };

	sub imlib_image_get_height()
		returns int32 is native(LIB) { ... };

	sub imlib_image_get_filename()
		returns Str is native(LIB) { ... };

	sub imlib_image_set_has_alpha(int8)
		is native(LIB) { ... };

	sub imlib_image_has_alpha()
		returns int8 is native(LIB) { ... };

	sub imlib_image_set_changes_on_disk()
		is native(LIB) { ... };

	sub imlib_image_set_border(Imlib2::Border)
		is native(LIB) { ... };

	sub imlib_image_get_border(Imlib2::Border)
		is native(LIB) { ... };

	sub imlib_image_set_format(Str)
		is native(LIB) { ... };

	sub imlib_image_format()
		returns Str is native(LIB) { ... };

	sub imlib_image_set_irrelevant_format(int8)
		is native(LIB) { ... };

	sub imlib_image_set_irrelevant_border(int8)
		is native(LIB) { ... };

	sub imlib_image_set_irrelevant_alpha(int8)
		is native(LIB) { ... };

	### rendering functions ###

	sub imlib_blend_image_onto_image(Imlib2, int8, Int, Int, Int, Int, Int, Int, Int, Int)
		is native(LIB) { ... };

	### creation functions ###

	sub imlib_create_image(int32, int32)
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_clone_image()
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_create_cropped_image(int32, int32, int32, int32)
		returns Imlib2::Image is native(LIB) { ... };

	sub imlib_create_cropped_scaled_image(int32, int32, int32, int32, int32, int32)
		returns Imlib2::Image is native(LIB) { ... };

	### imlib updates ###
	
	### image modification ###

	sub imlib_image_flip_horizontal()
		is native(LIB) { ... };

	sub imlib_image_flip_vertical()
		is native(LIB) { ... };

	sub imlib_image_flip_diagonal()
		is native(LIB) { ... };

	sub imlib_image_orientate(int32)
		is native(LIB) { ... };

	sub imlib_image_blur(int32)
		is native(LIB) { ... };

	sub imlib_image_sharpen(int32)
		is native(LIB) { ... };

	sub imlib_image_tile()
		is native(LIB) { ... };

	sub imlib_image_tile_horizontal()
		is native(LIB) { ... };

	sub imlib_image_tile_vertical()
		is native(LIB) { ... };

	### fonts and text ###

	sub imlib_load_font(Str)
		returns Imlib2::Font is native(LIB) { ... };

	sub imlib_free_font()
		is native(LIB) { ... };

	sub imlib_text_draw(int32, int32, Str)
		is native(LIB) { ... };

	sub imlib_text_draw_with_return_metrics(int32 $x, int32 $y, Str $text,
			CArray[int32] $w, CArray[int32] $h, CArray[int32] $ha, CArray[int32] $va)
		is native(LIB) { ... };

	sub imlib_get_text_size(Str $text, CArray[int32] $w, CArray[int32] $h)
		is native(LIB) { ... };

	sub imlib_get_text_advance(Str $text, CArray[int32] $ha, CArray[int32] $va)
		is native(LIB) { ... };

	sub imlib_get_text_inset(Str)
		returns int32 is native(LIB) { ... };

	sub imlib_text_get_index_and_location(
			Str $text, int32 $x, int32 $y,
			CArray[int32] $cx, CArray[int32] $cy,
			CArray[int32] $cw, CArray[int32] $ch)
		returns int32 is native(LIB) { ... };

	sub imlib_text_get_location_at_index(
			Str $text, int32 $x, int32 $y,
			CArray[int32] $cx, CArray[int32] $cy,
			CArray[int32] $cw, CArray[int32] $ch)
		is native(LIB) { ... };

	sub imlib_get_font_ascent()
		returns int32 is native(LIB) { ... };
	
	sub imlib_get_font_descent()
		returns int32 is native(LIB) { ... };

	sub imlib_get_maximum_font_ascent()
		returns int32 is native(LIB) { ... };

	sub imlib_get_maximum_font_descent()
		returns int32 is native(LIB) { ... };

	sub imlib_add_path_to_font_path(Str)
		is native(LIB) { ... };

	sub imlib_remove_path_from_font_path(Str)
		is native(LIB) { ... };

	sub imlib_list_font_path(CArray[int32] $number)
		returns CArray[Str] is native(LIB) { ... };

	sub imlib_list_fonts(CArray[int32] $number)
		returns CArray[Str] is native(LIB) { ... };

	sub imlib_free_font_list(CArray[Str] $list, int32 $number)
		is native(LIB) { ... };

	sub imlib_set_font_cache_size(int32)
		is native(LIB) { ... };

	sub imlib_get_font_cache_size()
		returns int32 is native(LIB) { ... };

	sub imlib_flush_font_cache()
		is native(LIB) { ... };

	### color modifiers ###

	### drawing on images ###

	sub imlib_image_draw_pixel(int32, int32, int8) 
		returns Imlib2::Updates is native(LIB) { ... };

	sub imlib_image_draw_line(int32, int32, int32, int32, int8) 
		returns Imlib2::Updates is native(LIB) { ... };

	sub imlib_image_draw_rectangle(int32, int32, int32, int32)
		is native(LIB) { ... };

	sub imlib_image_fill_rectangle(int32, int32, int32, int32)
		is native(LIB) { ... };

	### polygons ###

	sub imlib_polygon_new()
		returns Imlib2::Polygon is native(LIB) { ... };

	sub imlib_image_draw_polygon(Imlib2::Polygon, int8)
		is native(LIB) { ... };

	sub imlib_image_fill_polygon(Imlib2::Polygon)
		is native(LIB) { ... };

	### ellipses/circumferences ###

	sub imlib_image_draw_ellipse(int32, int32, int32, int32)
		is native(LIB) { ... };

	sub imlib_image_fill_ellipse(int32, int32, int32, int32)
		is native(LIB) { ... };
	
	### color ranges ###

	sub imlib_create_color_range()
		returns Imlib2::ColorRange is native(LIB) { ... };

	sub imlib_free_color_range()
		is native(LIB) { ... };

	sub imlib_add_color_to_color_range(int32)
		is native(LIB) { ... };

	sub imlib_image_fill_color_range_rectangle(int32, int32, int32, int32, num64)
		is native(LIB) { ... };

	sub imlib_image_fill_hsva_color_range_rectangle(int32, int32, int32, int32, num64)
		is native(LIB) { ... };

	### saving ###

	sub imlib_save_image(Str)
		is native(LIB) { ... };
	
	sub imlib_save_image_with_error_return(Str $filename, CArray[int32] $error_return)
		is native(LIB) { ... };

	### rotation/skewing ###

	sub imlib_create_rotated_image(num) 	 
		returns Imlib2::Image is native(LIB) { ... };

	### image filters ###

	### auxiliary functions ###

	sub hexcode(Int $red, Int $green, Int $blue) {
		return ("#", sprintf('%02x', $red), sprintf('%02x', $green), sprintf('%02x', $blue)).join("");
	}

	sub copy_CArray2p6Array(@carray, Int $number_elements) returns Array {
		my @p6array;
		loop (my $i=0; $i < $number_elements; $i++) {
			@p6array.push(@carray[$i]);
		}
		return @p6array;
	}

	############
	
	sub imlib_apply_color_modifier()
		is native(LIB) { ... };

	sub imlib_apply_color_modifier_to_rectangle(Int, Int, Int, Int)
		is native(LIB) { ... };

	sub imlib_free_color_modifier()
		is native(LIB) { ... };

	sub imlib_create_color_modifier()
		returns Imlib2::ColorModifier is native(LIB) { ... };
		
	sub imlib_get_color_modifier_tables(CArray[int8], CArray[int8], CArray[int8], CArray[int8])
		is native(LIB) { ... };

	sub imlib_set_color_modifier_tables(CArray[int8], CArray[int8], CArray[int8], CArray[int8])
		is native(LIB) { ... };

	sub imlib_modify_color_modifier_brightness(num)
		is native(LIB) { ... };
	
	sub imlib_modify_color_modifier_contrast(num)
		is native(LIB) { ... };

	sub imlib_modify_color_modifier_gamma(num)
		is native(LIB) { ... };

	sub imlib_reset_color_modifier()
		is native(LIB) { ... };

	### METHODS ###
	
	method new() {
		return self;
	}

	### context setting/getting ###

	method context_set_dither_mask(Bool $dither_mask) {
		imlib_context_set_dither_mask($dither_mask ?? 1 !! 0);
	}

	method context_get_dither_mask() returns Bool {
		return imlib_context_get_dither_mask().Bool;
	}

	method context_set_anti_alias(Bool $anti_alias) {
		imlib_context_set_anti_alias($anti_alias ?? 1 !! 0);
	}

	method context_get_anti_alias() returns Bool {
		return imlib_context_get_anti_alias().Bool;
	}

	method context_set_mask_alpha_threshold(Int $mask_alpha_threshold where 0..255) {
		imlib_context_set_mask_alpha_threshold($mask_alpha_threshold);
	}

	method context_get_mask_alpha_threshold() returns Int {
		return imlib_context_get_mask_alpha_threshold();
	}

	method context_set_dither(Bool $dither) {
		imlib_context_set_dither($dither ?? 1 !! 0);
	}

	method context_get_dither() returns Bool {
		return imlib_context_get_dither().Bool;
	}

	method context_set_blend(Bool $blend) {
		imlib_context_set_blend($blend ?? 1 !! 0);
	}

	method context_get_blend() returns Bool {
		return imlib_context_get_blend().Bool;
	}

	method context_get_color_modifier() returns Imlib2::ColorModifier {
		return imlib_context_get_color_modifier();
	}

	method context_set_operation(OperationMode $operation) {
		imlib_context_set_operation($operation.value);
	}

	method context_get_operation() returns OperationMode {
		return OperationMode(imlib_context_get_operation());
	}

	method context_get_font() returns Imlib2::Font {
		return imlib_context_get_font();
	}

	method context_set_direction(TextDirection $text_direction) {
		imlib_context_set_direction($text_direction.value);
	}

	method context_get_direction() returns TextDirection {
		return TextDirection(imlib_context_get_direction());
	}

	method context_set_angle(Rat $angle where -360.0 .. 360.0 = 0.0) {
		imlib_context_set_angle($angle.Num);
	}

	method context_get_angle() returns Rat {
		return imlib_context_get_angle().Rat;
	}

	# RGBA
	multi method context_set_color(
			Int :$red! where 0..255,
			Int :$green! where 0..255,
			Int :$blue! where 0..255,
			Int :$alpha where 0..255 = 255) {

		imlib_context_set_color($red, $green, $blue, $alpha);
	}

	# HSVA
	multi method context_set_color(
			Int :$hue! where 0..360,
			Int :$saturation! where 0 .. 100,
			Int :$value! where 0 .. 100,
			Int :$alpha where 0..255 = 255) {

		imlib_context_set_color_hsva($hue.Num, ($saturation/100).Num, ($value/100).Num, $alpha);
	}

	# HLSA
	multi method context_set_color(
			Int :$hue! where 0 .. 360,
			Int :$lightness! where 0 .. 100,
			Int :$saturation! where 0 .. 100,
			Int :$alpha where 0..255 = 255) {

		imlib_context_set_color_hlsa($hue.Num, ($lightness/100).Num, ($saturation/100).Num, $alpha);
	}
	
	# CMYA
	multi method context_set_color(
			Int :$cyan! where 0..255,
			Int :$magenta! where 0..255,
			Int :$yellow! where 0..255,
			Int :$alpha where 0..255 = 255) {

		imlib_context_set_color_cmya($cyan, $magenta, $yellow, $alpha);
	}

	multi method context_set_color(Str $hexstr where /^\#<[A..Fa..f\d]>**6..8$/) {
		my ($red, $green, $blue, $alpha) = (0, 0, 0, 255);

		if $hexstr.chars == 7 | 9 {
			$red = ("0x" ~ $hexstr.substr(1,2)).Int;
			$green = ("0x" ~ $hexstr.substr(3,2)).Int;
			$blue = ("0x" ~ $hexstr.substr(5,2)).Int;
		}
		$alpha = ("0x" ~ $hexstr.substr(7,2)).Int if $hexstr.chars == 9;

		imlib_context_set_color($red, $green, $blue, $alpha);
	}

	multi method context_set_color(Int $hex_value where { $hex_value >= 0 }) {

		my $red = (($hex_value +> 24) +& 0xFF).Int;
		my $green = (($hex_value +> 16) +& 0xFF).Int;
		my $blue = (($hex_value +> 8) +& 0xFF).Int;
		my $alpha = (($hex_value) +& 0xFF).Int;

		imlib_context_set_color($red, $green, $blue, $alpha);
	}

	multi method context_get_color(%color_channels) {
		my @red_color := CArray[int32].new();
		my @green_color := CArray[int32].new();
		my @blue_color := CArray[int32].new();
		my @alpha_color := CArray[int32].new();
		@red_color[0] = @green_color[0] = @blue_color[0] = @alpha_color[0] = 0;

		imlib_context_get_color(@red_color, @green_color, @blue_color, @alpha_color);

		%color_channels{'red'} = @red_color[0];
		%color_channels{'green'} = @green_color[0];
		%color_channels{'blue'} = @blue_color[0];
		%color_channels{'alpha'} = @alpha_color[0];
		%color_channels{'hexcode'} = hexcode(@red_color[0], @green_color[0], @blue_color[0]);
	}

	# It needs to be fixed.
	multi method context_get_color() returns Hash {
		my $color_channels = imlib_context_get_imlib_color();

		return {
			red     => $color_channels.red,
			green   => $color_channels.green,
			blue    => $color_channels.blue,
			alpha   => $color_channels.alpha,
			hexcode => hexcode($color_channels.red, $color_channels.green, $color_channels.blue)};
	}

	# It needs to be fixed.
	method context_get_color_hsva(%hsva_channels) {
		my @hue := CArray[num32].new();
		my @saturation := CArray[num32].new();
		my @value := CArray[num32].new();
		my @alpha := CArray[int32].new();
		@hue[0] = @saturation[0] = @value[0] = 0e0;
		@alpha[0] = 0;

		imlib_context_get_color_hsva(@hue, @saturation, @value, @alpha);

		%hsva_channels{'hue'} = @hue[0].Rat;
		%hsva_channels{'saturation'} = (@saturation[0]).Rat;
		%hsva_channels{'value'} = @value[0].Rat;
		%hsva_channels{'alpha'} = @alpha[0];
	}

	# It needs to be fixed.
	method context_get_color_hlsa(%hlsa_channels) {
		my @hue := CArray[num32].new();
		my @lightness := CArray[num32].new();
		my @saturation := CArray[num32].new();
		my @alpha := CArray[int32].new();
		@hue[0] = @lightness[0] = @saturation[0] = 0e0;
		@alpha[0] = 0;

		imlib_context_get_color_hlsa(@hue, @lightness, @saturation, @alpha);

		%hlsa_channels{'hue'} = @hue[0].Rat;
		%hlsa_channels{'lightness'} = (@lightness[0]).Rat;
		%hlsa_channels{'saturation'} = @saturation[0].Rat;
		%hlsa_channels{'alpha'} = @alpha[0];
	}

	method context_get_color_cmya(%cmya_channels) {
		my @cyan := CArray[int32].new();
		my @magenta := CArray[int32].new();
		my @yellow := CArray[int32].new();
		my @alpha := CArray[int32].new();
		@cyan[0] = @magenta[0] = @yellow[0] = @alpha[0] = 0;

		imlib_context_get_color_cmya(@cyan, @magenta, @yellow, @alpha);

		%cmya_channels{'cyan'} = @cyan[0];
		%cmya_channels{'magenta'} = @magenta[0];
		%cmya_channels{'yellow'} = @yellow[0];
		%cmya_channels{'alpha'} = @alpha[0];
	}

	method context_get_color_range() returns Imlib2::ColorRange {
		return imlib_context_get_color_range();
	}

	method context_get_image() returns Imlib2::Image {
		return imlib_context_get_image();
	}

	method context_set_cliprect(
			Int :$x where {$x >= 0} = 0,
			Int :$y where {$y >= 0} = 0,
			Int :$width where {$width >= 0},
			Int :$height where {$height >= 0}) {
		imlib_context_set_cliprect($x, $y, $width, $height);
	}

	method context_get_cliprect(%cliprect) {
		my @x := CArray[int32].new();
		my @y := CArray[int32].new();
		my @w := CArray[int32].new();
		my @h := CArray[int32].new();
		@x[0] = @y[0] = @w[0] = @h[0] = 0;

		imlib_context_get_cliprect(@x, @y, @w, @h);

		%cliprect{'x'} = @x[0];
		%cliprect{'y'} = @y[0];
		%cliprect{'width'} = @w[0];
		%cliprect{'height'} = @h[0];
	}

	method set_cache_size(Int $bytes where {$bytes >= 0} = 0) {
		imlib_set_cache_size($bytes);
	}

	method get_cache_size() returns Int {
		return imlib_get_cache_size();
	}

	method set_color_usage(Int $max where {$max >= 0} = 256) {
		imlib_set_color_usage($max);
	}
	
	method get_color_usage() returns Int {
		return imlib_get_color_usage();
	}

	### loading functions ###

	multi method load_image(Str $filename) returns Imlib2::Image {
		return imlib_load_image($filename);
	}

	multi method load_image (
		Str :$filename,
		Bool :$immediately = False,
		Bool :$cache = True) returns Imlib2::Image {

		if $immediately {
			return $cache ??
				imlib_load_image_immediately($filename) !!
				imlib_load_image_immediately_without_cache($filename);
		}
		return $cache ??
			imlib_load_image($filename) !!
			imlib_load_image_without_cache($filename);
	}

	multi method load_image(
		Str $filename,
		LoadError $error_return is rw) returns Imlib2::Image {

		my @error := CArray[int32].new();
		@error[0] = 0;
		my $image = imlib_load_image_with_error_return($filename, @error);
		$error_return = LoadError(@error[0]);
		return $image;
	}

	method free_image(Bool $decache = False) {
		$decache ?? imlib_free_image_and_decache() !! imlib_free_image();
	}

	method flush_loaders() {
		imlib_flush_loaders();
	}

	### query/modify image parameters ###

	method image_get_width() returns Int {
		return imlib_image_get_width();
	}

	method image_get_height() returns Int {
		return imlib_image_get_height();
	}

	method image_get_size() {
		return (imlib_image_get_width(), imlib_image_get_height());
	}

	method image_get_filename() returns Str {
		return imlib_image_get_filename();
	}

	method image_set_has_alpha(Bool $has_alpha) {
		imlib_image_set_has_alpha($has_alpha ?? 1 !! 0);
	}

	method image_has_alpha() returns Bool {
		return imlib_image_has_alpha() ?? True !! False;
	}
	
	method image_set_changes_on_disk() {
		imlib_image_set_changes_on_disk();
	}

	method new_border(
			Int :$left where { $left >= 0 } = 0,
			Int :$right where { $right >= 0 } = 0,
			Int :$top where { $top >= 0 } = 0,
			Int :$bottom where { $bottom >= 0 } = 0,
		) returns Imlib2::Border {

		my $border = Imlib2::Border.new();
		#$border.init($left, $right, $top, $bottom);
		return $border;
	}

	# It needs to be fixed.
	method image_set_border(Imlib2::Border $border) {
		imlib_image_set_border($border);
	}

	# It needs to be fixed.
	method image_get_border(Imlib2::Border $border) {
		imlib_image_get_border($border);
	}

	method image_set_format(Str $format) {
		imlib_image_set_format($format);
	}

	method image_get_format() returns Str {
		return imlib_image_format();
	}

	method image_set_irrelevant_format(Bool $irrelevant) {
		imlib_image_set_irrelevant_format($irrelevant ?? 1 !! 0);
	}
	
	method image_set_irrelevant_border(Bool $irrelevant) {
		imlib_image_set_irrelevant_border($irrelevant ?? 1 !! 0);
	}
	
	method image_set_irrelevant_alpha(Bool $irrelevant) {
		imlib_image_set_irrelevant_alpha($irrelevant ?? 1 !! 0);
	}

	### rendering functions ###

	method blend_image_onto_image(
		Parcel :$source!(
			Imlib2::Image :$image!,
			Parcel :location($sl)(Int $sx where { $sx >= 0 }, Int $sy where { $sy >= 0 }) = (0, 0),
			Parcel :size($ss)!(Int $sw where { $sw > 0 }, Int $sh where { $sh > 0 })
		),
		Parcel :$destination!(
			Parcel :location($dl)!(Int $dx, Int $dy),
			Parcel :size($ds)!(Int $dw where { $dw > 0 }, Int $dh where { $dh > 0 })
		),
		Bool :$merge_alpha = False) {

		imlib_blend_image_onto_image($image, $merge_alpha ?? 1 !! 0,
				$sx, $sy, $sw, $sh,
				$dx, $dy, $dw, $dh);
	}

	### creation functions ###

	method create_image(Int $width, Int $height) returns Imlib2::Image {
		return imlib_create_image($width, $height);
	}

	method clone_image() returns Imlib2::Image {
		return imlib_clone_image();
	}

	# Crop and Scale
	multi method create_resized_image(
		Parcel :$location(Int $x where { $x >= 0 }, Int $y where { $y >= 0 }) = (0, 0),
		Parcel :$scale!(Int $sw where { $sw >= 0 }, Int $sh where { $sh >= 0 }),
		Parcel :$crop!(Int $cw where { $cw >= 0 }, Int $ch where { $ch >= 0 })
		) returns Imlib2::Image {

		my $w = imlib_image_get_width();
		my $h = imlib_image_get_height();
		$x = 0 unless $x < $w;
		$y = 0 unless $y < $h;
		$cw = $w if $cw > $w;
		$ch = $h if $ch > $h;

		return imlib_create_cropped_scaled_image($x, $y, $cw, $ch, $sw, $sh);
	}

	# Scale
	multi method create_resized_image(
		Parcel :$location(Int $x where { $x >= 0 }, Int $y where { $y >= 0 }) = (0, 0),
		Parcel :$scale!(Int $sw where { $sw >= 0 }, Int $sh where { $sh >= 0 })
		) returns Imlib2::Image {

		my $w = imlib_image_get_width();
		my $h = imlib_image_get_height();
		$x = 0 unless $x < $w;
		$y = 0 unless $y < $h;

		return imlib_create_cropped_scaled_image($x, $y, $w - $x, $h - $y, $sw, $sh);
	}
	# Crop
	multi method create_resized_image(
		Parcel :$location(Int $x where { $x >= 0 }, Int $y where { $y >= 0 }) = (0, 0),
		Parcel :$crop!(Int $cw where { $cw >= 0 }, Int $ch where { $ch >= 0 })
		) returns Imlib2::Image {

		my $w = imlib_image_get_width();
		my $h = imlib_image_get_height();
		$x = 0 unless $x < $w;
		$y = 0 unless $y < $h;
		$cw = $w if $cw > $w;
		$ch = $h if $ch > $h;

		return imlib_create_cropped_image($x, $y, $cw, $ch);
	}

	### imlib updates ###
	
	### image modification ###

	method image_flip(FlipMode $flip) {
		given $flip {
			imlib_image_flip_horizontal() when FLIP_HORIZONTAL;
			imlib_image_flip_vertical() when FLIP_VERTICAL;
			imlib_image_flip_diagonal() when FLIP_DIAGONAL;
		}
	}
	
	method image_orientate(RotationMode $rotation) {
		imlib_image_orientate($rotation.value);
	}

	method image_blur(Int $radius where 0..128) {
		imlib_image_blur($radius);
	}

	method image_sharpen(Int $radius where 0..128) {
		imlib_image_sharpen($radius);
	}

	method image_tile(TileMode $tile = TILE_BOTH) {
		given $tile {
			imlib_image_tile_horizontal() when TILE_HORIZONTAL;
			imlib_image_tile_vertical() when TILE_VERTICAL;
			imlib_image_tile() when TILE_BOTH;
		}
	}

	### fonts and text ###

	method load_font(Str $name, Int $size) returns Imlib2::Font {
		return imlib_load_font(($name, $size.Str).join("/"));
	}

	method free_font() {
		imlib_free_font();
	}

	multi method text_draw(Int $x, Int $y, Str $text) {
		imlib_text_draw($x, $y, $text);
	}

	multi method text_draw(Int $x, Int $y, Str $text, %metrics) {
		my @w := CArray[int32].new();
		my @h := CArray[int32].new();
		my @ha := CArray[int32].new();
		my @va := CArray[int32].new();
		@w[0] = @h[0] = @ha[0] = @va[0] = 0;

		imlib_text_draw_with_return_metrics($x, $y, $text, @w, @h, @ha, @va);
		%metrics{'width'} = @w[0];
		%metrics{'height'} = @h[0];
		%metrics{'horizontal_advance'} = @ha[0];
		%metrics{'vertical_advance'} = @va[0];
	}

	method get_text_size(
			Str $text,
			Int $width_return is rw,
			Int $height_return is rw) {
		my @w := CArray[int32].new();
		my @h := CArray[int32].new();
		@w[0] = @h[0] = 0;
		imlib_get_text_size($text, @w, @h);
		$width_return = @w[0];
		$height_return = @h[0];
	}

	method get_text_advance(
			Str $text,
			Int $horizontal_advance is rw,
			Int $vertical_advance is rw) {
		my @ha := CArray[int32].new();
		my @va := CArray[int32].new();
		@ha[0] = @va[0] = 0;
		imlib_get_text_advance($text, @ha, @va);
		$horizontal_advance = @ha[0];
		$vertical_advance = @va[0];
	}

	method get_text_inset(Str $text) returns Int {
		return imlib_get_text_inset($text);
	}

	#
	# NOTE:
	# imlib_text_get_location_at_index and imlib_text_get_index_and_location
	# needs to be fixed.
	#
	method text_get_index_and_location(
			Str $text,
			Int $x where {$x >= 0},
			Int $y where {$y >= 0},
			%character) returns Int {

		my @cx := CArray[int32].new();
		my @cy := CArray[int32].new();
		my @cw := CArray[int32].new();
		my @ch := CArray[int32].new();
		@cx[0] = @cy[0] = @cw[0] = @ch[0] = 0;

		my Int $char_number = imlib_text_get_index_and_location($text, $x, $y, @cx, @cy, @cw, @ch);
		if $char_number != -1 {
			%character{'x'} = @cx[0];
			%character{'y'} = @cy[0];
			%character{'width'} = @cw[0];
			%character{'height'} = @ch[0];
		}
		return $char_number;
	}

	# this only work if text_get_index_and_location return > -1
	method text_get_location_at_index(
			Str $text,
			Int $x where {$x >= 0},
			Int $y where {$y >= 0},
			%geometry) {

		my @cx := CArray[int32].new();
		my @cy := CArray[int32].new();
		my @cw := CArray[int32].new();
		my @ch := CArray[int32].new();
		@cx[0] = @cy[0] = @cw[0] = @ch[0] = 0;

		imlib_text_get_location_at_index($text, $x, $y, @cx, @cy, @cw, @ch);
		%geometry{'x'} = @cx[0];
		%geometry{'y'} = @cy[0];
		%geometry{'width'} = @cw[0];
		%geometry{'height'} = @ch[0];
	}

	method get_font_ascent() returns Int {
		return imlib_get_font_ascent();
	}

	method get_font_descent() returns Int {
		return imlib_get_font_descent();
	}

	method get_maximum_font_ascent() returns Int {
		return imlib_get_maximum_font_ascent();
	}

	method get_maximum_font_descent() {
		return imlib_get_maximum_font_descent();
	}

	method add_path_to_font_path(Str $path) {
		imlib_add_path_to_font_path($path);
	}

	method remove_path_from_font_path(Str $path) {
		imlib_remove_path_from_font_path($path);
	}

	method list_font_path() returns Array {
		my @n := CArray[int32].new();
		@n[0] = 0;
		my @list := imlib_list_font_path(@n);
		return copy_CArray2p6Array(@list, @n[0]);
	}

	method list_fonts() returns Array {
		my @n := CArray[int32].new();
		@n[0] = 0;
		my @list := imlib_list_fonts(@n);
		my @copy = copy_CArray2p6Array(@list, @n[0]);
		imlib_free_font_list(@list, @n[0]);
		return @copy;
	}

	method set_font_cache_size(Int $bytes) {
		imlib_set_font_cache_size($bytes);
	}
	
	method get_font_cache_size() returns Int {
		return imlib_get_font_cache_size();
	}

	method flush_font_cache() {
		imlib_flush_font_cache();
	}

	### color modifiers ###

	### drawing on images ###

	method image_draw_pixel(
			Int $x where { $x >= 0 },
			Int $y where { $y >= 0 },
			Bool $update = False) returns Imlib2::Updates {

		return imlib_image_draw_pixel($x, $y, $update ?? 1 !! 0);
	}

	method image_draw_line(
		Parcel :$start(Int $x1 where { $x1 >= 0 }, Int $y1 where { $y1 >= 0 }) = (0, 0),
		Parcel :$end!(Int $x2 where { $x2 > 0 }, Int $y2 where { $y2 > 0 }),
		Bool :$update = False) returns Imlib2::Updates {

		return imlib_image_draw_line($x1, $y1, $x2, $y2, $update ?? 1 !! 0);
	}

	method image_draw_rectangle(
		Parcel :$location(Int $x where { $x >= 0 }, Int $y where { $y >= 0 }) = (0, 0),
		Parcel :$size!(Int $w where { $w > 0 }, Int $h where { $h > 0 }),
		Bool :$fill = False,
		Bool :$gradient = False,
		Rat :$angle where -360.0 .. 360.0 = 0.0,
		Bool :$hsva = False) {

		if $fill {
			if $gradient {
				$hsva ?? imlib_image_fill_hsva_color_range_rectangle($x, $y, $w, $h, $angle.Num) !!
				imlib_image_fill_color_range_rectangle($x, $y, $w, $h, $angle.Num);
			} else {
				imlib_image_fill_rectangle($x, $y, $w, $h);
			}
		} else {
			imlib_image_draw_rectangle($x, $y, $w, $h);
		}
	}

	### polygons ###

	method polygon_new() returns Imlib2::Polygon {
		return imlib_polygon_new();
	}

	method image_draw_polygon(
		Imlib2::Polygon $polygon,
		Bool :$fill = False,
		Bool :$closed = True) {

		$fill ??
			imlib_image_fill_polygon($polygon) !!
			imlib_image_draw_polygon($polygon, $closed ?? 1 !! 0);
	}

	### ellipses/circumferences ###

	method image_draw_ellipse(
		Parcel :$center!(Int $xc, Int $yc),
		Parcel :$amplitude!(Int $a where { $a > 0 }, Int $b where { $b > 0 }),
		  Bool :$fill = False) {

		$fill ??
			imlib_image_fill_ellipse($xc, $yc, $a, $b) !!
			imlib_image_draw_ellipse($xc, $yc, $a, $b);
	}

	method image_draw_circumference(
			Parcel :$center!(Int $xc, Int $yc),
			   Int :$radius! where { $radius > 0 },
			  Bool :$fill = False) {

		$fill ??
			imlib_image_fill_ellipse($xc, $yc, $radius, $radius) !!
			imlib_image_draw_ellipse($xc, $yc, $radius, $radius);
	}

	### color ranges ###

	method create_color_range() returns Imlib2::ColorRange {
		return imlib_create_color_range();
	}

	method free_color_range() {
		imlib_free_color_range();
	}

	method add_color_to_color_range(Int $distance_away) {
		imlib_add_color_to_color_range($distance_away);
	}

	### saving ###

	multi method save_image($filename) {
		imlib_save_image($filename);
	}
	
	multi method save_image(Str $filename, LoadError $error_return is rw) {
		my @error := CArray[int32].new();
		@error[0] = 0;
		imlib_save_image_with_error_return($filename, @error);
		$error_return = LoadError(@error[0]);
	}

	### rotation/skewing ###

	method create_rotated_image(Rat $angle where -360.0 .. 360.0) returns Imlib2::Image {
		return imlib_create_rotated_image(($angle * pi/180).Num);
	}

	### image filters ###

	#####################

	method apply_color_modifier() {
		imlib_apply_color_modifier();
	}

	method apply_color_modifier_to_rectangle(
		Int :$x where {$x >= 0} = 0,
		Int :$y where {$y >= 0} = 0,
		Int :$width where {$width >= 0},
		Int :$height where {$height >= 0}) {

		imlib_apply_color_modifier_to_rectangle($x, $y, $width, $height);
	}

	method free_color_modifier() {
		imlib_free_color_modifier();
	}

	method create_color_modifier() {
		return imlib_create_color_modifier();
	}	

	method get_color_modifier_tables(@red_table, @green_table, @blue_table, @alpha_table) {
		imlib_get_color_modifier_tables(@red_table, @green_table, @blue_table, @alpha_table);
	}

	method set_color_modifier_tables(@red_table, @green_table, @blue_table, @alpha_table) {
		imlib_set_color_modifier_tables(@red_table, @green_table, @blue_table, @alpha_table);
	}

	method modify_color_modifier_brightness(Rat $brightness_value where -1.0 .. 1.0 = 0.0) {
		imlib_modify_color_modifier_brightness($brightness_value.Num);
	}

	method modify_color_modifier_contrast(Rat $contrast_value where 0.0 .. 2.0 = 1.0) {
		imlib_modify_color_modifier_contrast($contrast_value.Num);
	}

	method modify_color_modifier_gamma(Rat $gamma_value where 0.5 .. 2.0 = 1.0) {
		imlib_modify_color_modifier_gamma($gamma_value.Num);
	}

	method reset_color_modifier() {
		imlib_reset_color_modifier();
	}
}
