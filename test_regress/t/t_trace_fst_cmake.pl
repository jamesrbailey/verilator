#!/usr/bin/env perl
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2020 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }

scenarios(vlt_all => 1);

compile(
    v_flags2 => ["--trace-fst"],
    verilator_make_gmake => 0,
    verilator_make_cmake => 1,
);

execute(
);

fst_identical($Self->trace_filename, $Self->{golden_filename});

ok(1);
1;
