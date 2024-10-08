#!/usr/bin/env perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2003-2009 by Wilson Snyder. This program is free software; you
# can redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

scenarios(simulator => 1);

top_filename("t/t_cover_line.v");

compile(
    verilator_flags2 => ['--cc --coverage-line --trace --trace-coverage +define+ATTRIBUTE'],
    );

execute(
    );

run(cmd => ["$ENV{VERILATOR_ROOT}/bin/verilator_coverage",
            "--annotate-points",
            "--annotate", "$Self->{obj_dir}/annotated",
            "$Self->{obj_dir}/coverage.dat",
    ],
    verilator_run => 1,
    );

files_identical("$Self->{obj_dir}/annotated/t_cover_line.v", "t/t_cover_line.out");
vcd_identical("$Self->{obj_dir}/simx.vcd", $Self->{golden_filename});

ok(1);
1;
