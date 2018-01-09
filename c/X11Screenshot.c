/*
Probably simplest screenshot application
gcc -O2 -o X11Screenshot X11Screenshot.c -lX11
./X11Screenshot > screenshot.ppm
./X11Screenshot | convert - -resize 512 screenshot.jpg
*/

#include <X11/Xlib.h>
#include <X11/X.h>
#include <stdio.h>

int main()
{
	Display *display = XOpenDisplay(NULL);
	if (display == NULL)
		return -1;
	Window root = DefaultRootWindow(display);
	XWindowAttributes gwa;

	XGetWindowAttributes(display, root, &gwa);
	XImage *image = XGetImage(display, root, 0, 0, gwa.width, gwa.height,
	                          AllPlanes, ZPixmap);
	if (image == NULL)
		return -1;

	/* Generate PPM header */
	puts("P6");
	printf("%d %d\n", image->width, image->height);
	puts("255");

	int bpp = image->bits_per_pixel / 8;
	char line[image->width * 3];

	for (int y = 0; y < image->height; y++)
	{
		for (int x = 0; x < image->width; x++)
		{
			unsigned char *c =
				image->data + x * bpp + y * image->width * bpp;
			line[x * 3 + 0] = *(c + 2);
			line[x * 3 + 1] = *(c + 1);
			line[x * 3 + 2] = *(c + 0);
		}
		fwrite(line, 1, sizeof(line), stdout);

	}

	return 0;
}
