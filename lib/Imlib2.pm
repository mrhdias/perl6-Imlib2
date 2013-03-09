use NativeCall;

constant LIB = 'libImlib2.so';
enum TextDirection <TEXT_TO_RIGHT TEXT_TO_LEFT TEXT_TO_DOWN TEXT_TO_UP TEXT_TO_ANGLE>;

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
	sub imlib_polygon_add_point(Imlib2::Polygon, Int, Int)
		is native(LIB) { ... };
	
	sub imlib_polygon_contains_point(Imlib2::Polygon, Int, Int)
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

	sub imlib_context_set_cliprect(Int, Int, Int, Int)
		is native(LIB) { ... };

	sub imlib_context_set_dither_mask(int8)
		is native(LIB) { ... };

	sub imlib_context_get_dither_mask()
		returns int8 is native(LIB) { ... };

	sub imlib_context_set_mask_alpha_threshold(Int)
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

	sub imlib_context_get_color_range()
		returns Imlib2::ColorRange is native(LIB) { ... };

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
	
	sub imlib_context_get_font()
		returns Imlib2::Font is native(LIB) { ... };
		
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
	
	sub imlib_context_set_color(Int, Int, Int, Int)
		is native(LIB) { ... };
		
	sub imlib_create_cropped_image(Int, Int, Int, Int)
		returns Imlib2::Image is native(LIB) { ... };
		
	sub imlib_create_cropped_scaled_image(Int, Int, Int, Int, Int, Int)
		returns Imlib2::Image is native(LIB) { ... };
	
	sub imlib_free_image()
		is native(LIB) { ... };
	
	sub imlib_save_image(Str)
		is native(LIB) { ... };
	
	sub imlib_load_image(Str)
		returns Imlib2::Image is native(LIB) { ... };
	
	sub imlib_create_image(Int, Int)
		returns Imlib2::Image is native(LIB) { ... };
	
	sub imlib_image_get_filename()
		returns Str is native(LIB) { ... };
	
	sub imlib_image_get_width()
		returns Int is native(LIB) { ... };
	
	sub imlib_image_get_height()
		returns Int is native(LIB) { ... };
	
	sub imlib_image_draw_polygon(Imlib2::Polygon, int8)
		is native(LIB) { ... };
	
	sub imlib_image_draw_rectangle(Int, Int, Int, Int)
		is native(LIB) { ... };
		
	sub imlib_image_fill_rectangle(Int, Int, Int, Int)
		is native(LIB) { ... };
	
	sub imlib_image_fill_polygon(Imlib2::Polygon)
		is native(LIB) { ... };
	
	sub imlib_image_set_format(Str)
		is native(LIB) { ... };
	
	sub imlib_image_blur(Int)
		is native(LIB) { ... };
	
	sub imlib_image_set_has_alpha(int8)
		is native(LIB) { ... };
		
	sub imlib_image_sharpen(Int)
		is native(LIB) { ... };

	sub imlib_blend_image_onto_image(Imlib2, int8, Int, Int, Int, Int, Int, Int, Int, Int)
		is native(LIB) { ... };

	### Polygon ###

	sub imlib_polygon_new()
		returns Imlib2::Polygon is native(LIB) { ... };
		
	### Text Direction ###
	
	sub imlib_context_get_direction()
		returns Int is native(LIB) { ... };
	
	sub imlib_context_set_direction(Int)
		is native(LIB) { ... };
	
	sub imlib_context_set_angle(num)
		is native(LIB) { ... };
	
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
	
	method context_get_color_range() {
		return imlib_context_get_color_range();
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
	
	method context_get_font() {
		return imlib_context_get_font();
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
	
	method free_image() {
		imlib_free_image();
	}
	
	method save_image($filename) {
		imlib_save_image($filename);
	}
	
	method create_image(Int $width, Int $height) {
		return imlib_create_image($width, $height);
	}
	
	method load_image(Str $filename) {
		return imlib_load_image($filename);
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
	
	method image_get_filename() {
		return imlib_image_get_filename();
	}
	
	method image_get_height() {
		return imlib_image_get_height();
	}
	
	method image_get_width() {
		return imlib_image_get_width();
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
	
	method image_set_format($filename) {
		imlib_image_set_format($filename);
	}
	
	method image_blur($radius) {
		imlib_image_blur($radius)	
	}
	
	method image_sharpen($radius) {
		imlib_image_sharpen($radius)	
	}
	
	method image_set_has_alpha(Bool $alpha) {
		imlib_image_set_has_alpha($alpha ?? 1 !! 0);
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
	
	### Text Direction ###
	
	method context_get_direction() {
		return imlib_context_get_direction();
	}
	
	method context_set_direction(TextDirection $text_direction) {
		imlib_context_set_direction($text_direction.value);
	}
	
	method context_set_angle(num $angle = 0e0) {
		imlib_context_set_angle($angle);
	}
}
