#!/usr/bin/perl
if (!$::Driver) { use FindBin; exec("$FindBin::Bin/bootstrap.pl", @ARGV, $0); die; }
# DESCRIPTION: Verilator: Verilog Test driver/expect definition
#
# Copyright 2020 by Geza Lore. This program is free software; you can
# redistribute it and/or modify it under the terms of either the GNU
# Lesser General Public License Version 3 or the Perl Artistic License
# Version 2.0.
# SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

scenarios(simulator => 1);

if ($Self->{nc}) {
    # For NC, compile twice, first just to generate DPI headers
    compile(
        nc_flags2 => ["+ncdpiimpheader+$Self->{obj_dir}/dpi-imp.h"]
        );
}

compile(
    v_flags2 => ["t/t_dpi_open_query.cpp"],
    verilator_flags2 => ["-Wall -Wno-DECLFILENAME"],
    # NC: Gdd the obj_dir to the C include path
    nc_flags2 => ["+ncscargs+-I$Self->{obj_dir}"],
    # ModelSim: Generate DPI header, add obj_dir to the C include path
    ms_flags2 => ["-dpiheader $Self->{obj_dir}/dpi.h",
                  "-ccflags -I$Self->{obj_dir}"],
    );

execute(
    );

ok(1);
1;
