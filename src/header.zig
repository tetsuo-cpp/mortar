const expect = @import("std").testing.expect;

// Mortar supports the UStar format.
pub const TarHeader = packed struct {
    file_name: [100]u8,
    file_mode: [8]u8,
    user_id: [8]u8,
    group_id: [8]u8,
    file_size_bytes: [12]u8,
    modify_time: [12]u8,
    checksum: [8]u8,
    link: [1]u8,
    link_name: [100]u8,
    magic: [6]u8,
    version: [2]u8,
    user_name: [32]u8,
    group_name: [32]u8,
    device_major: [8]u8,
    device_minor: [8]u8,
    file_prefix: [155]u8,
    padding: [12]u8,
};

test "TarHeader size check" {
    comptime {
        expect(@sizeOf(TarHeader) == 512);
    }
}
