const w4 = @import("wasm4.zig");
const Vec = @import("vec.zig");

const Self = @This();

pos: Vec,

pub fn new(begin: Vec) Self {
    return .{ .pos = begin };
}

pub fn reset(self: *Self, pos: Vec) void {
    self.pos = pos;
}

pub fn draw(self: Self) void {
    w4.DRAW_COLORS.* = 0x0021;
    w4.blit(&bits, self.pos.x*8, self.pos.y*8, 8, 8, w4.BLIT_1BPP);
}

const bits = [8]u8{
    0b00001000,
    0b00010000,
    0b00010000,
    0b01111100,
    0b11111110,
    0b01111110,
    0b00111100,
    0b00011000,
};
