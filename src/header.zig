pub const TarHeader = packed struct {
    file_name: u8[100],
    file_mode: u8[8],
    user_id: u8[8],
    group_id: u8[8],
    file_size_bytes: u8[12],
    modify_time: u8[12],
    checksum: u8[12],
    link: u8[1],
    link_name: u8[100],
};
