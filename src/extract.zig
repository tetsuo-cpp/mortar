const std = @import("std");
const fs = std.fs;
const fmt = std.fmt;
const TarHeader = @import("header.zig").TarHeader;

const TarExtractedFile = struct {
    file_name: []u8,
    buf: []u8,

    fn init(file_name: []u8, buf: []u8) TarExtractedFile {
        return TarExtractedFile{
            .file_name = file_name,
            .buf = buf,
        };
    }
};

const TarExtractIterator = struct {
    buf: []u8,
    pos: u32,

    fn init(buf: []u8) TarExtractIterator {
        return TarExtractIterator{
            .buf = buf,
            .pos = 0,
        };
    }

    fn next(self: *TarExtractIterator) !?TarExtractedFile {
        const stdout = std.io.getStdOut().outStream();
        if (self.pos >= self.buf.len)
            return null;
        const header_buf = self.buf[self.pos .. self.pos + @sizeOf(TarHeader)];
        const header = @ptrCast(*TarHeader, header_buf);
        self.pos += @sizeOf(TarHeader);
        // const file_size = try fmt.parseInt(i32, &file_size_bytes, 8);
        // try stdout.print("Magic is {} and file size is {}.\n", .{ header.magic, file_size });
        return null;
    }
};

pub fn extractArchive(file_name: []u8, alloc: *std.mem.Allocator) !void {
    // Open the archive file.
    var cwd = fs.cwd();
    // defer cwd.close();
    var file = try cwd.openFile(file_name, fs.File.OpenFlags{ .read = true });
    // defer file.close();

    // Read into a heap allocated buffer.
    const size = try file.getEndPos();
    var buf = try alloc.alloc(u8, size);
    defer alloc.free(buf);
    const read_size = try file.preadAll(buf, 0);
    std.debug.assert(size == read_size);

    var iter = TarExtractIterator.init(buf);
    while (try iter.next()) |extracted_file| {}
}
