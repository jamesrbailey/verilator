#!/usr/bin/env perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

scenarios(vlt_all => 1);

top_filename("t/t_threads_crazy.v");

compile(
    verilator_flags2 => ['--cc'],
    threads => $Self->{vltmt} ? 2 : 1,
    context_threads => 1024
    );

execute(
    );

if ($Self->{vltmt}) {
    file_grep($Self->{run_log_filename}, qr/System has \d+ hardware threads but simulation thread count set to 1024\. This will likely cause significant slowdown\./);
}

ok(1);
1;
