#use encoding 'big5', STDIN => 'big5', STDOUT => 'big5';

use Encode qw/from_to/;

use File::Copy; 
use Getopt::Mixed;
use Encode;

binmode(STDOUT, ":utf8");

BEGIN { $| = 1 }

$num_args = $#ARGV + 1;
if ($num_args < 1) {
  print "\nUsage: daily.pl SRC_FILE DST_FILE\n";
  exit;
}

$daily_file = $ARGV[0];
$output = $ARGV[1];
%daily = ();

if ( ! open(FH, "<", $daily_file) ) {
    system("cd C:/WLAN/Trunk.git && git log > ./GitLog.txt");
    open(FH, "<", $daily_file) or die "Can't open $daily_file: $!";
}


open(OUTFILE, "+>", $output) or die "Can't open out.txt $!";

$ic = "";
$report = "";
while ( ! eof(FH) ) {

    defined( $_ = <FH> ) or die "readline failed for $daily_file: $!";

    if ($_ =~ m/\[(\w+)\] (.*)/) {
        $ic = $1;
        $daily{$ic} .= $& . "\n";
    } elsif ($_ =~ m/^[^\n\w](.*)/) {
        $daily{$ic} .= $1 . "\n";
    }
}

while ((my $ic, my $report) = each(%daily)){
    #$ic = decode("utf8", $ic);
    #Encode::_utf8_on($ic);
    #Encode::_utf8_on($report);
    #$report = encode('utf8', $report);
    #print OUTFILE "\Q$ic\E";
    #print OUTFILE "\Q$report\E";
    print  OUTFILE "------$ic------\n\n";
    print  OUTFILE "$report\n";
    #if (Encode::is_utf8($ic)) {
    #    print "hi";
    #} else {
    #    print "no";
    #}
    #print encode("big5", decode("utf8", $ic));
    #print encode("big5", decode("utf8", $report));
}
