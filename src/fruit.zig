const std = @import("std");
const w4 = @import("wasm4.zig");
const Vec = @import("vec.zig");

const Self = @This();

var random: std.rand.Random = undefined;

pos: Vec,
rnd: std.rand.Random,

pub fn new(begin: Vec) Self {
    var prng = std.rand.DefaultPrng.init(0);
    var rnd = prng.random();
    return .{
        .pos = begin,
        .rnd = rnd,
    };
}

pub fn reset(self: *Self) void {
    self.pos = Vec.new(
        self.rnd.intRangeLessThan(i32, 0, 20),
        self.rnd.intRangeLessThan(i32, 0, 20),
    );
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
