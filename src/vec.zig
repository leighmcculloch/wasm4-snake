const Self = @This();

x: i32,
y: i32,

pub fn new(x: i32, y: i32) Self {
    return .{ .x = x, .y = y };
}

pub fn eq(self: Self, o: Self) bool {
    return self.x == o.x and self.y == o.y;
}

pub fn xor(self: Self, o: Self) Self {
    return .{
        .x = self.x ^ o.x,
        .y = self.y ^ o.y,
    };
}

pub fn mod(self: Self, m: i32) Self {
    return .{
        .x = @mod(self.x, m),
        .y = @mod(self.y, m),
    };
}
