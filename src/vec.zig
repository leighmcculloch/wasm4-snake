const Self = @This();

x: i32,
y: i32,

pub fn new(x: i32, y: i32) Self {
    return .{ .x = x, .y = y };
}

pub fn eq(self: Self, o: Self) bool {
    return self.x == o.x and self.y == o.y;
}
