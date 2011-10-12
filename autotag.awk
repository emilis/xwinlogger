##############################################################################
#
# A script that automaticly adds tags to the XWinLogger log entries and
# prints the output in CSV format.
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

function compile_regexp(pattern) 
{
    if (pattern == "*")
    {
        return ".*";
    }
    else
    {
        gsub(/\//, "\/", pattern);
        gsub(/\./, "\.", pattern);
        gsub(/\*/, ".*", pattern);
        return pattern;
    }
}

# parses tagging patterns:
function get_pattern(tag, cmd, desk, class, name)
{
    if (tag && tag !~ /^#/)
    {
        tag_patterns[pc]   = tag;
        cmd_patterns[pc]   = compile_regexp( cmd );
        desk_patterns[pc]  = compile_regexp( desk );
        class_patterns[pc] = compile_regexp( class );
        name_patterns[pc]  = compile_regexp( name );

        #print (tag_patterns[pc], cmd_patterns[pc], desk_patterns[pc], class_patterns[pc], name_patterns[pc]);

        pc++
    }
}

# prints input lines with added tags:
function tag_line(time, duration, cmd, desk, class, name)
{
    tag = "";

    #print (class, class_patterns[0], class ~ class_patterns[0]);

    for (i in tag_patterns)
    {
        if (cmd ~ cmd_patterns[i] && desk ~ desk_patterns[i] && class ~ class_patterns[i] && name ~ name_patterns[i])
        {
            tag=tag_patterns[i];
        }
    }

    print (time, duration, cmd, desk, class, name, tag);
}



BEGIN {
    mode="patterns";

    pc=0;

    OFS=";"
}

# --- MAIN PROGRAM ---
{
    if (mode == "data")
    {
        FS="|";
        tag_line(substr($1, 12, 8), $2, $4, $5, $7, $8);
    }
    else
    {
        FS=" ";
        get_pattern($1, $2, $3, $4, $5);
    }
}

