const std = @import("std");
const w4 = @import("wasm4.zig");
const Vec = @import("vec.zig");

const Self = @This();

body: std.BoundedArray(Vec, 4),
direction: Vec,

pub fn new(begin: Vec, dir: Vec) Self {
    return .{
        .body = std.BoundedArray(Vec, 4).fromSlice(&.{
            Vec.new(begin.x - dir.x*2, begin.y - dir.y*2),
            Vec.new(begin.x - dir.x, begin.y - dir.y),
            Vec.new(begin.x, begin.y),
        }) catch @panic("couldn't init snake body"),
        .direction = dir,
    };
}

pub fn pos(self: Self) Vec {
    return self.body.get(0);
}

pub fn input(self: *Self, gamepad: u8) void {
    if (gamepad & w4.BUTTON_LEFT != 0) {
        self.direction.x = -1;
        self.direction.y = 0;
    }
    if (gamepad & w4.BUTTON_RIGHT != 0) {
        self.direction.x = 1;
        self.direction.y = 0;
    }
    if (gamepad & w4.BUTTON_UP != 0) {
        self.direction.x = 0;
        self.direction.y = -1;
    }
    if (gamepad & w4.BUTTON_DOWN != 0) {
        self.direction.x = 0;
        self.direction.y = 1;
    }
}

pub fn update(self: *Self) void {
    const parts = self.body.slice();
    var i: usize = parts.len - 1;
    while (i > 0) : (i -= 1) {
        parts[i] = .{
            .x = parts[i - 1].x,
            .y = parts[i - 1].y,
        };
    }
    parts[0] = .{
        .x = @mod(parts[0].x + self.direction.x, 20),
        .y = @mod(parts[0].y + self.direction.y, 20),
    };
}

pub fn draw(self: Self) void {
    w4.DRAW_COLORS.* = 0x0021;
    for (self.body.constSlice()) |part| {
        w4.rect(part.x * 8, part.y * 8, 8, 8);
    }
    w4.DRAW_COLORS.* = 0x0023;
    w4.rect(self.body.get(0).x * 8, self.body.get(0).y * 8, 8, 8);
}
