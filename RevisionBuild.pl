use File::Copy;

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
            print "git co $hash -b $version\r\n";

            chdir "C:\\WLAN\\Trunk.git" or die "$!";
            system "git checkout $hash -b $version";

            system "start C:/MassProductionKit/Utility/setenv.bat C:/WINDDK/3790~1.183 chk AMD64 WNET USB";
            $userinput = <STDIN>;
            mkdir "C:/WLAN/Trunk.git/RollBack/$version"; 
            copy("C:/WLAN/Trunk.git/RTLWlanU_WindowsDriver_/X64/rtwlanump.sys","C:/WLAN/Trunk.git/RollBack/$version/rtwlanump.sys") or die "Copy failed: $!";
        }
    }
}

close(FH);
