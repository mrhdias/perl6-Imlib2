Imlib2
======

![Imlib2 Logo](logotype/logo_32x32.png)  
Perl 6 interface to the Imlib2 image library.

Description
-----------
Perl6 binding for [Imlib2][1], a featureful and efficient image manipulation library, which produces high quality, anti-aliased output.
You will need this library installed in order to use Image-Imlib2 (preferably a recent version).

Synopsis
--------
WARNING: This module is Work in Progress, which means: this interface is not final. This will perhaps change in the future.
A sample of the code can be seen below.

    use Imlib2;

    my $tools = Imlib2.new();
    # Create a new raw image.
    my $rawimage = $tools.create_image(200, 200);
    exit() unless $rawimage;

    # Sets the current image Imlib2 will be using with its function calls.
    $rawimage.context_set_image();
 
    # Sets the color with which text, lines and rectangles are drawn when
    # being rendered onto an image.
    $tools.context_set_color(
        red   => 255,
        green => 127,
        blue  => 0,
        alpha => 255
    );
    
    $tools.image_fill_rectangle(
        x      => 0,
        y      => 0,
        width  => 200,
        height => 200
    );
    
    $tools.image_set_format("png");
    unlink("images/test_imlib2.png") if "images/test_imlib2.png".IO ~~ :e;
    $tools.save_image("images/test_imlib2.png");

    # Frees the image that is set as the current image in Imlib2's context. 
    $tools.free_image();

    exit();


Author
------
Henrique Dias <mrhdias@gmail.com>

See Also
--------
[Imlib2 Library Documentation][1]

License
-------

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.


[1]: http://docs.enlightenment.org/api/imlib2/html/ "Imlib2 Library Documentation"
