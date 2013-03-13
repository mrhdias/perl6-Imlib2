use NativeCall;

constant LIB = 'libImlib2.so';
enum TextDirection <
	TEXT_TO_RIGHT
	TEXT_TO_LEFT
	TEXT_TO_DOWN
	TEXT_TO_UP
	TEXT_TO_ANGLE>;
enum OperationMode <
	OP_COPY
	OP_ADD
	OP_SUBTRACT
	OP_RESHADE>;
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

class Imlib2::Border is repr('CStruct') {
	has int32 $.left;
	has int32 $.right;
	has int32 $.top;
	has int32 $.bottom;

	method init() {
		$!left = 0;
		$!right = 0;
		$!top = 0;
		$!bottom = 0;
	}
	multi method left(Int $l) { $!left = $l; }
	multi method right(Int $r) { $!right = $r; }
	multi method top(Int $t) { $!top = $t; }
	multi method bottom(Int $b) { $!bottom = $b; }	
	
	# this is a workaround, since NativeCall doesn't yet handle sized ints right
	multi method left() { return $!left; }
	multi method right() { return $!right; }
	multi method top() { return $!top; }
	multi method bottom() { return $!bottom; }
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

	method context_set_color_modifier() {
		imlib_context_set_color_modifier(self);
	}
}

class Imlib2::ColorRange is repr('CPointer') {
	sub imlib_context_set_color_range(Imlib2::ColorRange)
		is native(LIB) { ... };

	method context_set_color_range() {
		imlib_context_set_color_range(self);
	}	
}

class Imlib2::Font is repr('CPointer') {
	sub imlib_context_set_font(Imlib2::Font)
		is native(LIB) { ... };

	method context_set_font() {
		imlib_context_set_font(self);
	}
}

class Imlib2::Image is repr('CPointer') {
	sub imlib_context_set_image(Imlib2::Image)
		is native(LIB) { ... };

	method context_set_image() {
		imlib_context_set_image(self);
	}
}

class Imlib2::Polygon is repr('CPointer') {
	sub imlib_polygon_add_point(Imlib2::Polygon, int32, int32)
		is native(LIB) { ... };
	
	sub imlib_polygon_contains_point(Imlib2::Polygon, int32, int32)
		returns int8 is native(LIB) { ... };

	sub imlib_polygon_free(Imlib2::Polygon)
		is native(LIB) { ... };

	method polygon_add_points(*@points) {
		for @points -> Int $x, Int $y {
			imlib_polygon_add_point(self, $x, $y);
		}
	}

	method polygon_contains_point(Int $x, Int $y) {
		return imlib_polygon_contains_point(self, $x, $y);
	}

	method polygon_free() {
		imlib_polygon_free(self);
	}
}

class Imlib2 is repr('CPointer') {

	sub imlib_context_set_cliprect(int32, int32, int32, int32)
		is native(LIB) { ... };

	sub imlib_context_set_dither_mask(int8)
		is native(LIB) { ... };

	sub imlib_context_get_dither_mask()
		returns int8 is native(LIB) { ... };

	sub imlib_context_set_mask_alpha_threshold(int32)
		is native(LIB) { ... };

	sub imlib_context_get_mask_alpha_threshold()
		returns Int is native(LIB) { ... };

	sub imlib_context_set_anti_alias(int8)
		is native(LIB) { ... };

	sub imlib_context_get_anti_alias()
		returns int8 is native(LIB) { ... };

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
		
	sub imlib_set_cache_size(int32)
		is native(LIB) { ... };

	sub imlib_get_cache_size()
		returns int32 is native(LIB) { ... };

	sub imlib_set_color_usage(int32)
		is native(LIB) { ... };

	sub imlib_get_color_usage()
		returns int32 is native(LIB) { ... };

	sub imlib_flush_loaders()
		is native(LIB) { ... };

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

	### Color Modifier ###
	
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

	### Color Range ###

	sub imlib_create_color_range()
		returns Imlib2::ColorRange is native(LIB) { ... };

	sub imlib_add_color_to_color_range(Int)
		is native(LIB) { ... };

	sub imlib_image_fill_color_range_rectangle(Int, Int, Int, Int, num)
		is native(LIB) { ... };		

	sub imlib_image_fill_hsva_color_range_rectangle(Int, Int, Int, Int, num)
		is native(LIB) { ... };

	sub imlib_free_color_range()
		is native(LIB) { ... };
		
	### Font ###
	
	sub imlib_load_font(Str)
		returns Imlib2::Font is native(LIB) { ... };
	
	sub imlib_add_path_to_font_path(Str)
		is native(LIB) { ... };
		
	sub imlib_get_font_cache_size()
		returns Int is native(LIB) { ... };
		
	sub imlib_get_text_size(Str, Int $w is rw, Int $h is rw)
		is native(LIB) { ... };
	
	sub imlib_set_font_cache_size(Int)
		is native(LIB) { ... };
		
	sub imlib_text_draw(Int, Int, Str)
		is native(LIB) { ... };
	
	sub imlib_free_font()
		is native(LIB) { ... };
	
	### Image ###

	sub imlib_clone_image()
		returns Imlib2::Image is native(LIB) { ... };
		
	sub imlib_create_cropped_image(Int, Int, Int, Int)
		returns Imlib2::Image is native(LIB) { ... };
		
	sub imlib_create_cropped_scaled_image(Int, Int, Int, Int, Int, Int)
		returns Imlib2::Image is native(LIB) { ... };
	
	sub imlib_save_image(Str)
		is native(LIB) { ... };

	sub imlib_create_image(Int, Int)
		returns Imlib2::Image is native(LIB) { ... };
	
	sub imlib_image_draw_polygon(Imlib2::Polygon, int8)
		is native(LIB) { ... };
	
	sub imlib_image_draw_rectangle(Int, Int, Int, Int)
		is native(LIB) { ... };
		
	sub imlib_image_fill_rectangle(Int, Int, Int, Int)
		is native(LIB) { ... };
	
	sub imlib_image_fill_polygon(Imlib2::Polygon)
		is native(LIB) { ... };
	
	sub imlib_image_blur(Int)
		is native(LIB) { ... };
		
	sub imlib_image_sharpen(Int)
		is native(LIB) { ... };

	sub imlib_blend_image_onto_image(Imlib2, int8, Int, Int, Int, Int, Int, Int, Int, Int)
		is native(LIB) { ... };

	### Polygon ###

	sub imlib_polygon_new()
		returns Imlib2::Polygon is native(LIB) { ... };

	sub hexcode(Int $red, Int $green, Int $blue) {
		return ("#", sprintf('%02x', $red), sprintf('%02x', $green), sprintf('%02x', $blue)).join("");
	}
	
	### METHODS ###
	
	method new() {
		return self;
	}

	method context_set_cliprect(
			Int :$x where {$x >= 0} = 0,
			Int :$y where {$y >= 0} = 0,
			Int :$width where {$width >= 0},
			Int :$height where {$height >= 0}) {
		imlib_context_set_cliprect($x, $y, $width, $height);
	}

	method context_set_dither_mask(Bool $dither_mask) {
		imlib_context_set_dither_mask($dither_mask ?? 1 !! 0);
	}
	
	method context_get_dither_mask() {
		return imlib_context_get_dither_mask().Bool;
	}

	method context_set_mask_alpha_threshold(Int $mask_alpha_threshold where 0..255) {
		imlib_context_set_mask_alpha_threshold($mask_alpha_threshold);
	}
	
	method context_get_mask_alpha_threshold() {
		return imlib_context_get_mask_alpha_threshold();
	}
	
	method context_set_anti_alias(Bool $anti_alias) {
		imlib_context_set_anti_alias($anti_alias ?? 1 !! 0);
	}

	method context_get_anti_alias() {
		return imlib_context_get_anti_alias().Bool;
	}

	method context_set_dither(Bool $dither) {
		imlib_context_set_dither($dither ?? 1 !! 0);
	}

	method context_get_dither() {
		return imlib_context_get_dither().Bool;
	}
	
	method context_set_blend(Bool $blend) {
		imlib_context_set_blend($blend ?? 1 !! 0);
	}

	method context_get_blend() {
		return imlib_context_get_blend().Bool;
	}

	method context_get_color_modifier() {
		return imlib_context_get_color_modifier();
	}
	
	method context_set_operation(OperationMode $operation) {
		imlib_context_set_operation($operation.value);
	}
	
	method context_get_operation() {
		return OperationMode(imlib_context_get_operation());
	}

	method context_get_font() {
		return imlib_context_get_font();
	}

	method context_set_direction(TextDirection $text_direction) {
		imlib_context_set_direction($text_direction.value);
	}
	
	method context_get_direction() {
		return TextDirection(imlib_context_get_direction());
	}
	
	method context_set_angle(Rat $angle where -360.0 .. 360.0 = 0.0) {
		imlib_context_set_angle($angle.Num);
	}
	
	method context_get_angle() {
		return imlib_context_get_angle().Rat;
	}

	multi method context_set_color(
		Int :$red where 0..255 = 0,
		Int :$green where 0..255 = 0,
		Int :$blue where 0..255 = 0,
		Int :$alpha where 0..255 = 255) {

		imlib_context_set_color($red, $green, $blue, $alpha);
	}

	multi method context_set_color(
		Str $hexstr where /^\#<[A..Fa..f\d]>**6$/,
		Int $alpha where 0..255 = 255) {

		my $red = ("0x" ~ $hexstr.substr(1,2)).Int;
		my $green = ("0x" ~ $hexstr.substr(3,2)).Int;
		my $blue = ("0x" ~ $hexstr.substr(5,2)).Int;
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
	multi method context_get_color() {
		my $color_channels = imlib_context_get_imlib_color();

		return {
			red     => $color_channels.red,
			green   => $color_channels.green,
			blue    => $color_channels.blue,
			alpha   => $color_channels.alpha,
			hexcode => hexcode($color_channels.red, $color_channels.green, $color_channels.blue)};
	}

	method context_set_color_hsva(
			Rat :$hue where 0.0 .. 360.0,
			Rat :$saturation where 0.0 .. 1.0,
			Rat :$value where 0.0 .. 1.0,
			Int :$alpha where 0 .. 255 = 255) {

		imlib_context_set_color_hsva($hue.Num, $saturation.Num, $value.Num, $alpha);
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
	
	method context_set_color_hlsa(
			Rat :$hue where 0.0 .. 360.0,
			Rat :$lightness where 0.0 .. 1.0,
			Rat :$saturation where 0.0 .. 1.0,
			Int :$alpha where 0 .. 255 = 255) {

		imlib_context_set_color_hlsa($hue.Num, $lightness.Num, $saturation.Num, $alpha);
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

	method context_set_color_cmya(
		Int :$cyan where 0..255 = 0,
		Int :$magenta where 0..255 = 0,
		Int :$yellow where 0..255 = 0,
		Int :$alpha where 0..255 = 255) {

		imlib_context_set_color_cmya($cyan, $magenta, $yellow, $alpha);
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

	method context_get_color_range() {
		return imlib_context_get_color_range();
	}
	
	method context_get_image() {
		return imlib_context_get_image();
	}
	
	method set_cache_size(Int $bytes where {$bytes >= 0} = 0) {
		imlib_set_cache_size($bytes);
	}
	
	method get_cache_size() {
		return imlib_get_cache_size();
	}

	method set_color_usage(Int $max where {$max >= 0} = 256) {
		imlib_set_color_usage($max);
	}
	
	method get_color_usage() {
		return imlib_get_color_usage();
	}

	method flush_loaders() {
		imlib_flush_loaders();
	}

	multi method load_image(Str $filename) {
		return imlib_load_image($filename);
	}

	multi method load_image(
		Str :$filename,
		Bool :$immediately = False,
		Bool :$cache = True) {

		if $immediately {
			return $cache ??
				imlib_load_image_immediately($filename) !!
				imlib_load_image_immediately_without_cache($filename);
		}
		return $cache ??
			imlib_load_image($filename) !!
			imlib_load_image_without_cache($filename);
	}

	multi method load_image(Str $filename, LoadError $error_return is rw) {
		my @error := CArray[int32].new();
		@error[0] = 0;
		my $image = imlib_load_image_with_error_return($filename, @error);
		$error_return = LoadError(@error[0]);
		return $image;
	}

	method free_image(Bool $decache = False) {
		$decache ?? imlib_free_image_and_decache() !! imlib_free_image();
	}

	method image_get_width() {
		return imlib_image_get_width();
	}

	method image_get_height() {
		return imlib_image_get_height();
	}
	
	method image_get_size() {
		return {
			width  => imlib_image_get_width(),
			height => imlib_image_get_height()};
	}

	method image_get_filename() {
		return imlib_image_get_filename();
	}

	method image_set_has_alpha(Bool $has_alpha) {
		imlib_image_set_has_alpha($has_alpha ?? 1 !! 0);
	}
	
	method image_has_alpha() {
		return imlib_image_has_alpha() ?? True !! False;
	}

	method image_set_changes_on_disk() {
		imlib_image_set_changes_on_disk();
	}
	
	# It needs to be fixed.
	method image_set_border(Imlib2::Border $border) {
		imlib_image_set_border($border);
	}

	# It needs to be fixed.
	method image_get_border(Imlib2::Border $border) {
		imlib_image_get_border($border);
	}
	
	method new_border() {
		my $border = Imlib2::Border.new();
		$border.init();
		return $border;
	}

	method image_set_format(Str $filename) {
		imlib_image_set_format($filename);
	}
	
	method image_format() {
		return imlib_image_format();
	}

	### Color Modifier ###

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

	### Color Range ###
	
	method create_color_range() {
		return imlib_create_color_range();
	}
	
	method add_color_to_color_range(Int $distance_away) {
		imlib_add_color_to_color_range($distance_away);
	}
	
	method image_fill_color_range_rectangle(
		Int :$x = 0,
		Int :$y = 0,
		Int :$width!,
		Int :$height!,
		num :$angle = 0e0
		) {
		imlib_image_fill_color_range_rectangle($x, $y, $width, $height, $angle);
	}
	
	method image_fill_hsva_color_range_rectangle(
		Int :$x = 0,
		Int :$y = 0,
		Int :$width!,
		Int :$height!,
		num :$angle = 0e0
		) {
		imlib_image_fill_hsva_color_range_rectangle($x, $y, $width, $height, $angle);
	}
	
	method free_color_range() {
		imlib_free_color_range();
	}
	
	### Font ###

	method load_font(Str $name, Int $size) {
		return imlib_load_font($name ~ "/" ~ "$size");
	}

	method add_path_to_font_path($path) {
		imlib_add_path_to_font_path($path);
	}
	
	multi method font_cache_size(Int $bytes) {
		imlib_set_font_cache_size($bytes);
	}
	
	multi method font_cache_size() {
		return imlib_get_font_cache_size();
	}
	
	method get_text_size(Str $text, Int $width_return is rw, Int $height_return is rw) {
		imlib_get_text_size($text, $width_return, $height_return);
	}
	
	method text_draw(Int :$x where {$x >= 0} = 0, Int :$y where {$y >= 0} = 0, Str :$text) {
		imlib_text_draw($x, $y, $text);
	}
	
	method free_font() {
		imlib_free_font();
	}
	
	### Image ###

	method clone_image() {
		return imlib_clone_image();
	}
	
	method create_cropped_image(
		Int :$x where {$x >= 0} = 0,
		Int :$y where {$y >= 0} = 0,
		Int :$width where {$width >= 0},
		Int :$height where {$height >= 0}
		) {
		return imlib_create_cropped_image($x, $y, $width, $height);
	}
	
	method create_cropped_scaled_image(
		Int :$source_x where {$source_x >= 0} = 0,
		Int :$source_y where {$source_y >= 0} = 0,
		Int :$source_width where {$source_width >= 0},
		Int :$source_height where {$source_height >= 0},
		Int :$destination_width where {$destination_width >= 0},
		Int :$destination_height where {$destination_height >= 0}) {

		return imlib_create_cropped_scaled_image(
			$source_x, $source_y, $source_width, $source_height,
				$destination_width, $destination_height);
	}
	
	method save_image($filename) {
		imlib_save_image($filename);
	}
	
	method create_image(Int $width, Int $height) {
		return imlib_create_image($width, $height);
	}
	
	method image_fill_rectangle(
		Int :$x where {$x >= 0} = 0,
		Int :$y where {$y >= 0} = 0,
		Int :$width where {$width >= 0},
		Int :$height where {$height >= 0}) {

		imlib_image_fill_rectangle($x, $y, $width, $height);
	}
	
	method image_fill_polygon($polygon) {
		imlib_image_fill_polygon($polygon);
	}
	
	method image_draw_rectangle(
		Int :$x where {$x >= 0} = 0,
		Int :$y where {$y >= 0} = 0,
		Int :$width where {$width >= 0},
		Int :$height where {$height >= 0}) {

		imlib_image_draw_rectangle($x, $y, $width, $height);
	}
	
	method image_draw_polygon($polygon, Bool $closed = True) {
		imlib_image_draw_polygon($polygon, $closed ?? 1 !! 0);
	}
	
	method image_blur($radius) {
		imlib_image_blur($radius)	
	}
	
	method image_sharpen($radius) {
		imlib_image_sharpen($radius)	
	}
	
	method blend_image_onto_image(
		:$source_image!,
		Bool :$merge_alpha        = False,
		:$source_x           = 0,
		:$source_y           = 0,
		:$source_width       = 0,
		:$source_height      = 0,
		:$destination_x      = 0,
		:$destination_y      = 0,
		:$destination_width  = 0,
		:$destination_height = 0) {

		imlib_blend_image_onto_image($source_image, $merge_alpha ?? 1 !! 0,
			$source_x, $source_y, $source_width, $source_height,
				$destination_x, $destination_y, $destination_width,
					$destination_height);
	}
	
	### Polygon ###
	
	method polygon_new() {
		return imlib_polygon_new();
	}
}
