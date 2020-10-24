const std = @import("std");
const TarHeader = @import("header.zig").TarHeader;

fn usage() void {
    const stdout = std.io.getStdOut().outStream();
    stdout.print("usage: mortar <cmd>\n", .{}) catch unreachable;
}

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().outStream();
    errdefer usage();

    // Use an arena allocator.
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const alloc = &arena.allocator;

    // Parse command.
    var args = std.process.args();
    std.debug.assert(args.skip()); // The first arg is the process name.
    if (args.next(alloc)) |arg_iter| {
        const cmd = try arg_iter;
        if (std.mem.eql(u8, cmd, "extract")) {
            @panic("TODO: Implement extract.");
        } else if (std.mem.eql(u8, cmd, "archive")) {
            @panic("TODO: Implement archive.");
        } else {
            usage();
        }
    } else {
        usage();
    }
}
