##############################################################################
#
# A script that displays statistics about total tag durations in a tagged
# XWinLogger file.
# 
#    Copyright 2009 Emilis Dambauskas <emilis.d@gmail.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

function add_timeline_entry(time, duration, tag)
{
    hour = substr(time, 1, 2)
    timeline[hour " | " tag] += duration
}

BEGIN {
    FS  = ";"
    OFS = " | "
}

{
    tags[$7] += $2

    add_timeline_entry($1, $2, $7)
}

END {
    print "\nTag statistics:\n"

    print ("tag", "seconds")
    for (t in tags)
        print (t, tags[t]);

    print "\nTimeline:\n";

    for (h=0; h < 24; h++)
    {
        if (h < 10)
            h = "0" h;
        for (t in tags)
        {
            if (h " | " t in timeline)
                print (h, t, timeline[h " | " t]);
        }
    }

    print "\n"
}
