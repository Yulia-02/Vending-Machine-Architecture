#!/usr/bin/perl
use strict;
use warnings;

my $file = $ARGV[0] // "";
my $mode = $ARGV[1] // "";
my $chip_area = $ARGV[2] // 25000000;  # 5000 x 5000 lambda

if ($file eq "" || $mode eq "") {
    print "\nUsage:\n";
    print "  ./calc_density_fixed.pl <file.mag> metal1 [chip_area]\n";
    print "  ./calc_density_fixed.pl <file.mag> metal2 [chip_area]\n";
    print "  ./calc_density_fixed.pl <file.mag> poly   [chip_area]\n\n";
    exit;
}

my %layers;
if ($mode eq "metal1") {
    %layers = map { $_ => 1 } ("metal1");
} elsif ($mode eq "metal2") {
    %layers = map { $_ => 1 } ("metal2");
} elsif ($mode eq "poly") {
    %layers = map { $_ => 1 } (
        "polysilicon",
        "rpoly",
        "pseudo_rpoly",
        "ntransistor",
        "ptransistor"
    );
} else {
    die "Unknown mode '$mode'. Use metal1, metal2, or poly.\n";
}

open(my $fh, "<", $file) or die "\nCannot open file: $file\n\n";

my $scale_num = 1;
my $scale_den = 1;
my $current_layer = "";
my $totarea = 0;
my $rects = 0;

print "calculating total $mode area...\n";

while (my $line = <$fh>) {
    chomp $line;

    if ($line =~ /^magscale\s+(\d+)\s+(\d+)/) {
        $scale_num = $1;
        $scale_den = $2;
    }

    if ($line =~ /^<<\s+(.+?)\s+>>/) {
        $current_layer = $1;
        next;
    }

    if ($line =~ /^use/) {
        print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
        print "ERROR: this script does not work on magic files with subcells\n";
        print "You need to flatten your magic file first\n";
        print "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\n";
        die;
    }

    if ($line =~ /^rect\s+/ && exists $layers{$current_layer}) {
        my ($junk, $x1, $y1, $x2, $y2) = split(/\s+/, $line);

        my $scale = $scale_num / $scale_den;

        my $width  = abs($x2 - $x1) * $scale;
        my $height = abs($y2 - $y1) * $scale;
        my $area = $width * $height;

        $totarea += $area;
        $rects++;
    }
}

my $density = ($totarea / $chip_area) * 100;

print "====================================================\n";
print "File = $file\n";
print "Mode = $mode\n";
print "magscale = $scale_num $scale_den\n";
print "Rects counted = $rects\n";
printf("Total %s Area = %.2f lambda squared\n", $mode, $totarea);
printf("Given chip area = %.0f lambda squared, total %s density = %.5f percent\n",
       $chip_area, $mode, $density);
print "====================================================\n";
