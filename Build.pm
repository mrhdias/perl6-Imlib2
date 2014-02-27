use Panda::Common;
use Panda::Builder;

%*ENV{'LD_LIBRARY_PATH'} = join("/", $*CWD, "blib/lib");

my $o  = $*VM<config><o>;
my $so = $*VM<config><load_ext>;
my $name = "Imlib2";
my $libs = "-Wl,--no-as-needed -lImlib2";

class Build is Panda::Builder {
    method build(|) {
		my $c_line = "$*VM<config><cc> -c $*VM<config><cc_shared> $*VM<config><cc_o_out>src/$name$o "
						~ "$*VM<config><ccflags> src/$name.c";
		my $l_line = "$*VM<config><ld> $*VM<config><ld_load_flags> $*VM<config><ldflags> "
						~ "$*VM<config><libs>$libs $*VM<config><ld_out>src/$name$so src/$name$o";
		shell($c_line);
		shell($l_line);
		shell("rm src/$name$o");
		shell("mkdir -p blib/lib");
		shell("cp src/$name$so blib/lib");
    }
}

