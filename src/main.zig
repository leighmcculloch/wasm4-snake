const std = @import("std");
const w4 = @import("wasm4.zig");
const Vec = @import("vec.zig");
const Snake = @import("snake.zig");
const Fruit = @import("fruit.zig");

var snake1 = Snake.new(Vec.new(2, 10), Vec.new(1, 0));
var snake2 = Snake.new(Vec.new(18, 10), Vec.new(-1, 0));
var fruit: Fruit = undefined;

var snake1_score: u32 = 0;
var snake2_score: u32 = 0;

export fn start() void {
    w4.PALETTE.* = .{
        0x051f39,
        0x4a2480,
        0xc53a9d,
        0xff8e80,
    };
    fruit = Fruit.new(Vec.new(10, 10));
}

var frame_count: u32 = 0;
export fn update() void {
    frame_count += 1;
    snake1.input(w4.GAMEPAD1.*);
    snake2.input(w4.GAMEPAD2.*);
    if (frame_count % 15 == 0) {
        snake1.update();
        snake2.update();
        if (snake1.pos().eq(fruit.pos)) {
            snake1_score += 1;
            fruit.reset();
        }
        if (snake2.pos().eq(fruit.pos)) {
            snake2_score += 1;
            fruit.reset();
        }
    }
    fruit.draw();
    snake1.draw();
    snake2.draw();

    var score_buf: [11:0]u8 = undefined;
    if (std.fmt.bufPrint(&score_buf, "{}", .{snake1_score})) |buf| {
        w4.text(buf, 0, 0);
    } else |_| {}

    if (std.fmt.bufPrint(&score_buf, "{}", .{snake2_score})) |buf| {
        w4.text(buf, 160-@intCast(i32, buf.len)*8, 0);
    } else |_| {}
}
