const std = @import("std");
const extract = @import("extract.zig");

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

    // The first arg is the process name.
    var args = std.process.args();
    std.debug.assert(args.skip());

    // Push the arguments into a vector for convenience.
    var args_array = std.ArrayList([]u8).init(alloc);
    defer args_array.deinit();
    while (args.next(alloc)) |arg_iter| {
        const arg = try arg_iter;
        try args_array.append(arg);
    }

    if (args_array.items.len < 1) {
        usage();
        return;
    }
    const cmd = args_array.items[0];
    if (std.mem.eql(u8, cmd, "extract")) {
        if (args_array.items.len < 2) {
            usage();
            return;
        }
        const file_name = args_array.items[1];
        try extract.extractArchive(file_name, alloc);
    } else if (std.mem.eql(u8, cmd, "archive")) {
        @panic("TODO: Implement archive.");
    } else {
        usage();
    }
}
