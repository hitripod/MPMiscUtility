use File::Copy;
use Getopt::Mixed;

BEGIN { $| = 1 }

$num_args = $#ARGV + 1;
if ($num_args < 1) {
  print "\nUsage: RevisionBuild.pl v1234 v3169 ...\n";
  exit;
}

$log_file = "C:/WLAN/Trunk.git/GitLog.txt";
%log = ();

if ( ! open(FH, "<", $log_file) ) {
    system("cd C:/WLAN/Trunk.git && git log > ./GitLog.txt");
    open(FH, "<", $log_file) or die "Can't open $log_file: $!";
}

while ( ! eof(FH) ) {
    defined( $_ = <FH> ) or die "readline failed for $log_file: $!";
    if ($_ =~ m/commit (\w+)/) {
        $hash = $1;
        $_ = <FH>;
        $_ = <FH>;
        $_ = <FH>;
        $_ = <FH>;

        if ($_ =~ m/    ([vV]\d+)/) {
            $version = $1;
        }
        $log{$version} = $hash;
    }
}

foreach  my $v (@ARGV) {
    while ((my $version, my $hash) = each(%log)){
        if ($v =~/$version/i) {
            print "[Checking out $version...]\n\n";

            Getopt::Mixed::getOptions('t=s i=s help ?>help');

            if ($opt_t =~ "" or $opt_i =~ "") {
                print "opt_i=$opt_i, opt_t=$opt_t\n";
                print "revbuild -t [86|64] -i [e|u|s]\n";
                last;
            }
            print "git co -f $hash -b $version\r\n";

            $i = $opt_i ? lc $opt_i : "e";
            $t = $opt_t ? $opt_t : "86";

            if ($t =~ "86") {
                $o = "WXP"; $d = "WinXP_2K";
            } elsif ($t =~"64") {
                $o = "AMD64 WNET"; $d = "X64";
            } else {
                last;
            }

            print "$o $d $i";
            chdir "C:\\WLAN\\Trunk.git" or die "$!";
            if (-e "C:/WLAN/Trunk.git/RollBack/$version/$d/rtwlan$i\mp.sys") {
                print "Driver already compiled, skipped!";
                next;
            }
            

            system "git checkout -f $hash -b $version";
            system("cmd.exe", "/c", "C:/WINDDK/3790~1.183/bin/setenv.bat C:/WINDDK/3790~1.183 chk $o && cd C:/WLAN/Trunk.git && mpbuild c$i");
            mkdir "C:/WLAN/Trunk.git/RollBack/$version"; 
            mkdir "C:/WLAN/Trunk.git/RollBack/$version/$d"; 
            #copy("C:/WLAN/Trunk.git/RTLWlan$i\_WindowsDriver_/$d/rtwlan$i\mp.sys","C:/WLAN/Trunk.git/RollBack/$version/$d/rtwlan$i\mp.sys") or die "Copy failed: $!";
            copy("C:/WLAN/Trunk.git/RTLWlan$i\_WindowsDriver_/$d/rtwlan$i\mp.sys","C:/WLAN/Trunk.git/RollBack/$version/$d/rtwlan$i\mp.sys");
        }
    }
}

close(FH);
