//
//  gpu.m
//  Sean16CPU
//
//  Created by Frida Boleslawska on 27.09.24.
//

#import <Foundation/Foundation.h>
#include <Peripherals/Display/Display.h>

const uint8_t font4x8[96][8] = {
    // Character 32: ' ' (space)
    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
    // Character 33: '!'
    { 0x04, 0x04, 0x04, 0x04, 0x00, 0x00, 0x04, 0x00 },
    // Character 34: '"'
    { 0x0A, 0x0A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
    // Character 35: '#'
    { 0x0A, 0x0A, 0x0F, 0x0A, 0x0F, 0x0A, 0x0A, 0x00 },
    // Character 36: '$'
    { 0x04, 0x0F, 0x05, 0x0E, 0x14, 0x0F, 0x04, 0x00 },
    // Character 37: '%'
    { 0x03, 0x13, 0x08, 0x04, 0x02, 0x19, 0x18, 0x00 },
    // Character 38: '&'
    { 0x06, 0x09, 0x06, 0x16, 0x09, 0x19, 0x06, 0x00 },
    // Character 39: '''
    { 0x04, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
    // Character 40: '('
    { 0x02, 0x04, 0x04, 0x04, 0x04, 0x04, 0x02, 0x00 },
    // Character 41: ')'
    { 0x08, 0x04, 0x04, 0x04, 0x04, 0x04, 0x08, 0x00 },
    // Character 42: '*'
    { 0x00, 0x05, 0x02, 0x0F, 0x02, 0x05, 0x00, 0x00 },
    // Character 43: '+'
    { 0x00, 0x04, 0x04, 0x0F, 0x04, 0x04, 0x00, 0x00 },
    // Character 44: ','
    { 0x00, 0x00, 0x00, 0x00, 0x04, 0x04, 0x08, 0x00 },
    // Character 45: '-'
    { 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00, 0x00 },
    // Character 46: '.'
    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x0C, 0x00 },
    // Character 47: '/'
    { 0x01, 0x01, 0x02, 0x04, 0x08, 0x10, 0x10, 0x00 },
    // Character 48: '0'
    { 0x06, 0x09, 0x0B, 0x0D, 0x19, 0x11, 0x0E, 0x00 },
    // Character 49: '1'
    { 0x04, 0x0C, 0x04, 0x04, 0x04, 0x04, 0x0F, 0x00 },
    // Character 50: '2'
    { 0x0E, 0x11, 0x01, 0x02, 0x04, 0x08, 0x1F, 0x00 },
    // Character 51: '3'
    { 0x0E, 0x11, 0x01, 0x06, 0x01, 0x11, 0x0E, 0x00 },
    // Character 52: '4'
    { 0x02, 0x06, 0x0A, 0x12, 0x1F, 0x02, 0x02, 0x00 },
    // Character 53: '5'
    { 0x1F, 0x10, 0x1E, 0x01, 0x01, 0x11, 0x0E, 0x00 },
    // Character 54: '6'
    { 0x06, 0x08, 0x10, 0x1E, 0x11, 0x11, 0x0E, 0x00 },
    // Character 55: '7'
    { 0x1F, 0x01, 0x02, 0x04, 0x04, 0x08, 0x08, 0x00 },
    // Character 56: '8'
    { 0x0E, 0x11, 0x11, 0x0E, 0x11, 0x11, 0x0E, 0x00 },
    // Character 57: '9'
    { 0x0E, 0x11, 0x11, 0x0F, 0x01, 0x02, 0x0C, 0x00 },
    // Character 58: ':'
    { 0x00, 0x00, 0x0C, 0x0C, 0x00, 0x0C, 0x0C, 0x00 },
    // Character 59: ';'
    { 0x00, 0x00, 0x0C, 0x0C, 0x00, 0x0C, 0x08, 0x00 },
    // Character 60: '<'
    { 0x02, 0x04, 0x08, 0x10, 0x08, 0x04, 0x02, 0x00 },
    // Character 61: '='
    { 0x00, 0x00, 0x1F, 0x00, 0x1F, 0x00, 0x00, 0x00 },
    // Character 62: '>'
    { 0x08, 0x04, 0x02, 0x01, 0x02, 0x04, 0x08, 0x00 },
    // Character 63: '?'
    { 0x0E, 0x11, 0x01, 0x02, 0x04, 0x00, 0x04, 0x00 },
    // Character 64: '@'
    { 0x0E, 0x11, 0x15, 0x15, 0x1D, 0x11, 0x0E, 0x00 },
    // Character 65: 'A'
    { 0x0E, 0x11, 0x11, 0x1F, 0x11, 0x11, 0x11, 0x00 },
    // Character 66: 'B'
    { 0x1E, 0x09, 0x09, 0x0E, 0x09, 0x09, 0x1E, 0x00 },
    // Character 67: 'C'
    { 0x0E, 0x11, 0x10, 0x10, 0x10, 0x11, 0x0E, 0x00 },
    // Character 68: 'D'
    { 0x1E, 0x09, 0x09, 0x09, 0x09, 0x09, 0x1E, 0x00 },
    // Character 69: 'E'
    { 0x1F, 0x10, 0x10, 0x1E, 0x10, 0x10, 0x1F, 0x00 },
    // Character 70: 'F'
    { 0x1F, 0x10, 0x10, 0x1E, 0x10, 0x10, 0x10, 0x00 },
    // Character 71: 'G'
    { 0x0E, 0x11, 0x10, 0x17, 0x11, 0x11, 0x0E, 0x00 },
    // Character 72: 'H'
    { 0x11, 0x11, 0x11, 0x1F, 0x11, 0x11, 0x11, 0x00 },
    // Character 73: 'I'
    { 0x0E, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E, 0x00 },
    // Character 74: 'J'
    { 0x0F, 0x02, 0x02, 0x02, 0x02, 0x12, 0x0C, 0x00 },
    // Character 75: 'K'
    { 0x11, 0x12, 0x14, 0x18, 0x14, 0x12, 0x11, 0x00 },
    // Character 76: 'L'
    { 0x10, 0x10, 0x10, 0x10, 0x10, 0x10, 0x1F, 0x00 },
    // Character 77: 'M'
    { 0x11, 0x1B, 0x15, 0x15, 0x11, 0x11, 0x11, 0x00 },
    // Character 78: 'N'
    { 0x11, 0x11, 0x19, 0x15, 0x13, 0x11, 0x11, 0x00 },
    // Character 79: 'O'
    { 0x0E, 0x11, 0x11, 0x11, 0x11, 0x11, 0x0E, 0x00 },
    // Character 80: 'P'
    { 0x1E, 0x11, 0x11, 0x1E, 0x10, 0x10, 0x10, 0x00 },
    // Character 81: 'Q'
    { 0x0E, 0x11, 0x11, 0x11, 0x15, 0x12, 0x0D, 0x00 },
    // Character 82: 'R'
    { 0x1E, 0x11, 0x11, 0x1E, 0x14, 0x12, 0x11, 0x00 },
    // Character 83: 'S'
    { 0x0F, 0x10, 0x10, 0x0E, 0x01, 0x01, 0x1E, 0x00 },
    // Character 84: 'T'
    { 0x1F, 0x04, 0x04, 0x04, 0x04, 0x04, 0x04, 0x00 },
    // Character 85: 'U'
    { 0x11, 0x11, 0x11, 0x11, 0x11, 0x11, 0x0E, 0x00 },
    // Character 86: 'V'
    { 0x11, 0x11, 0x11, 0x11, 0x0A, 0x0A, 0x04, 0x00 },
    // Character 87: 'W'
    { 0x11, 0x11, 0x11, 0x15, 0x15, 0x1B, 0x11, 0x00 },
    // Character 88: 'X'
    { 0x11, 0x11, 0x0A, 0x04, 0x0A, 0x11, 0x11, 0x00 },
    // Character 89: 'Y'
    { 0x11, 0x11, 0x0A, 0x04, 0x04, 0x04, 0x04, 0x00 },
    // Character 90: 'Z'
    { 0x1F, 0x01, 0x02, 0x04, 0x08, 0x10, 0x1F, 0x00 },
    // Character 91: '['
    { 0x07, 0x04, 0x04, 0x04, 0x04, 0x04, 0x07, 0x00 },
    // Character 92: '\'
    { 0x10, 0x10, 0x08, 0x04, 0x02, 0x01, 0x01, 0x00 },
    // Character 93: ']'
    { 0x07, 0x02, 0x02, 0x02, 0x02, 0x02, 0x07, 0x00 },
    // Character 94: '^'
    { 0x04, 0x0A, 0x11, 0x00, 0x00, 0x00, 0x00, 0x00 },
    // Character 95: '_'
    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1F, 0x00 },
    // Character 96: '`'
    { 0x04, 0x04, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00 },
    // Character 97: 'a'
    { 0x00, 0x00, 0x0E, 0x01, 0x0F, 0x11, 0x0F, 0x00 },
    // Character 98: 'b'
    { 0x10, 0x10, 0x1E, 0x11, 0x11, 0x11, 0x1E, 0x00 },
    // Character 99: 'c'
    { 0x00, 0x00, 0x0E, 0x10, 0x10, 0x10, 0x0E, 0x00 },
    // Character 100: 'd'
    { 0x01, 0x01, 0x0F, 0x11, 0x11, 0x11, 0x0F, 0x00 },
    // Character 101: 'e'
    { 0x00, 0x00, 0x0E, 0x11, 0x1F, 0x10, 0x0E, 0x00 },
    // Character 102: 'f'
    { 0x06, 0x08, 0x1E, 0x08, 0x08, 0x08, 0x08, 0x00 },
    // Character 103: 'g'
    { 0x00, 0x0F, 0x11, 0x11, 0x0F, 0x01, 0x1E, 0x00 },
    // Character 104: 'h'
    { 0x10, 0x10, 0x1E, 0x11, 0x11, 0x11, 0x11, 0x00 },
    // Character 105: 'i'
    { 0x04, 0x00, 0x0C, 0x04, 0x04, 0x04, 0x0E, 0x00 },
    // Character 106: 'j'
    { 0x02, 0x00, 0x06, 0x02, 0x02, 0x12, 0x0C, 0x00 },
    // Character 107: 'k'
    { 0x08, 0x08, 0x09, 0x0E, 0x0C, 0x0A, 0x09, 0x00 },
    // Character 108: 'l'
    { 0x0C, 0x04, 0x04, 0x04, 0x04, 0x04, 0x0E, 0x00 },
    // Character 109: 'm'
    { 0x00, 0x00, 0x1B, 0x15, 0x15, 0x15, 0x15, 0x00 },
    // Character 110: 'n'
    { 0x00, 0x00, 0x1E, 0x11, 0x11, 0x11, 0x11, 0x00 },
    // Character 111: 'o'
    { 0x00, 0x00, 0x0E, 0x11, 0x11, 0x11, 0x0E, 0x00 },
    // Character 112: 'p'
    { 0x00, 0x1E, 0x11, 0x11, 0x1E, 0x10, 0x10, 0x00 },
    // Character 113: 'q'
    { 0x00, 0x0F, 0x11, 0x11, 0x0F, 0x01, 0x01, 0x00 },
    // Character 114: 'r'
    { 0x00, 0x00, 0x1E, 0x11, 0x10, 0x10, 0x10, 0x00 },
    // Character 115: 's'
    { 0x00, 0x00, 0x0E, 0x10, 0x0E, 0x01, 0x1E, 0x00 },
    // Character 116: 't'
    { 0x08, 0x08, 0x1E, 0x08, 0x08, 0x08, 0x06, 0x00 },
    // Character 117: 'u'
    { 0x00, 0x00, 0x11, 0x11, 0x11, 0x11, 0x0F, 0x00 },
    // Character 118: 'v'
    { 0x00, 0x00, 0x11, 0x11, 0x11, 0x0A, 0x04, 0x00 },
    // Character 119: 'w'
    { 0x00, 0x00, 0x11, 0x11, 0x15, 0x15, 0x0A, 0x00 },
    // Character 120: 'x'
    { 0x00, 0x00, 0x11, 0x0A, 0x04, 0x0A, 0x11, 0x00 },
    // Character 121: 'y'
    { 0x00, 0x00, 0x11, 0x11, 0x0F, 0x01, 0x0E, 0x00 },
    // Character 122: 'z'
    { 0x00, 0x00, 0x1F, 0x02, 0x04, 0x08, 0x1F, 0x00 },
    // Character 123: '{'
    { 0x02, 0x04, 0x04, 0x08, 0x04, 0x04, 0x02, 0x00 },
    // Character 124: '|'
    { 0x04, 0x04, 0x04, 0x00, 0x04, 0x04, 0x04, 0x00 },
    // Character 125: '}'
    { 0x08, 0x04, 0x04, 0x02, 0x04, 0x04, 0x08, 0x00 },
    // Character 126: '~'
    { 0x00, 0x00, 0x06, 0x09, 0x00, 0x00, 0x00, 0x00 }
};

void clearScreen(void) {
    MyScreenEmulatorView *screen = getEmulator();
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [screen clear];
    });
}

void setpixel(int x, int y, uint8_t color) {
    MyScreenEmulatorView *screen = getEmulator();
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [screen setPixelAtX:x y:y colorIndex:(NSInteger)color];
    });
}

void drawLine(int x0, int y0, int x1, int y1, uint8_t color) {
    int dx = abs(x1 - x0);
    int dy = abs(y1 - y0);

    int sx = (x0 < x1) ? 1 : -1;
    int sy = (y0 < y1) ? 1 : -1;

    int err = dx - dy;

    while (1) {
        // Set the pixel at the current coordinates
        setpixel(x0, y0, color);

        // If we've reached the endpoint, break the loop
        if (x0 == x1 && y0 == y1) break;

        int e2 = 2 * err;
        
        if (e2 > -dy) {
            err -= dy;
            x0 += sx;
        }
        
        if (e2 < dx) {
            err += dx;
            y0 += sy;
        }
    }
}

void drawCharacter(uint8_t x, uint8_t y, char ascii, uint8_t color) {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (ascii < 32 || ascii > 127) return;

        const uint8_t* characterBitmap = font4x8[ascii - 32];

        for (uint8_t row = 0; row < 8; row++) {
            uint8_t rowBitmap = characterBitmap[row];

            for (uint8_t col = 0; col < 5; col++) {
                uint8_t pixelOn = (rowBitmap >> col) & 0x1;

                if (pixelOn) {
                    setpixel(x + (3 - col), y + row, color);
                }
            }
        }
    });
}

uint8_t getColorOfPixel(uint8_t x, uint8_t y) {
    MyScreenEmulatorView *screen = getEmulator();
    
    NSInteger color = [screen colorIndexAtPixelX:x y:y];
    
    return (uint8_t)color;
}
