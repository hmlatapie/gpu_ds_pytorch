#!/usr/bin/perl
use Data::Dumper;
use Carp;
use Time::HiRes qw(time sleep);
use Getopt::Long;

$usage = <<EOS;
$0 cmd options
	valid commands:
		build
		run
		   e.g. `anaconda_gpu.pl run` with backticks at the CLI
	options:
EOS

GetOptions(
	'stringparam=s' => \$options{stringparam},
	'booleanparam' => \$options{booleanparam}
	);

confess $usage
	if !@ARGV;

$command = shift;

if($command eq 'build')
{
   
   $cmd = "nvidia-docker build -t anaconda_gpu .";
   execute($cmd);
}
elsif($command eq 'run')
{
   $pwd = `pwd`;
   chomp $pwd;
   $cmd = "nvidia-docker run --net=host --env=DISPLAY -v $ENV{HOME}/.Xauthority:/root/.Xauthority  -v $pwd:$pwd -w $pwd --rm -it anaconda_gpu";   

   print "$cmd\n";
}
else
{
	confess $usage;
}

sub execute
{
  my $cmd = shift;
  my ($f);
   open $f, "$cmd |";
   print
      while <$f>;
}