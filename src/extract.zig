const std = @import("std");
const fs = std.fs;
const TarHeader = @import("header.zig").TarHeader;

pub fn extractArchive(file_name: []u8, alloc: *std.mem.Allocator) !void {
    const stdout = std.io.getStdOut().outStream();

    // Open the archive file.
    var cwd = fs.cwd();
    // defer cwd.close();
    var file = try cwd.openFile(file_name, fs.File.OpenFlags{ .read = true });
    // defer file.close();

    // Read into a heap allocated buffer.
    const size = try file.getEndPos();
    var buf = try alloc.alloc(u8, size);
    const read_size = try file.preadAll(buf, 0);
    std.debug.assert(size == read_size);
    const header = @ptrCast(*TarHeader, buf);
    try stdout.print("Magic is {}.\n", .{header.magic});
}
