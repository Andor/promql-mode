#!/usr/bin/perl -w

use strict;

my %docs = ();
my $f = '';
my $doc = '';
my $state = '';
my $params = '';
sub done_parsing {
    #    $params =~ s/\b(v|t|b|tf|sf|s|max) //g;
    $params =~ s/(\(|, )scalar/$1s scalar/g;
    $params =~ s/b instant-vector/v instant-vector/g;
    $params =~ s/(\(|, )range-vector/$1v range-vector/g;
    $params =~ s/[()]/"/g;
    $params =~ s/, /" "/g;
    $doc =~ s/^ +//g;
    $doc =~ s/ +$//g;
    my @value = ( $params, $doc );
    $docs{$f} = \@value;
    $f = '';
    $doc = '';
}
while (<>) {
    if (m/^\s*$/) {
	# skip empty strings
    }
    elsif (/^## \`<aggregation>_over_time\(\)\`/) { # paragraph with aggs functions
	$state = 'aggs';
    }
    elsif ($state eq 'aggs') {
	if (/^\* \`([a-z_]+)\(([^)]+)\)\`: (.+)$/) {
	    $f = $1;
	    $params = "($2)";
	    $doc = $3;
	    done_parsing;
	}
    }
    else {
	if (/^## \`(.*)\(\)\`$/) { # paragraphs with function names
	    if ($f ne "") { done_parsing; }
	    $f = $1;
	}
	elsif (/^\`$f(\([^)]+\))\` (.+)$/) {
	    $params = $1;
	    $doc = $2;
	}
	elsif (/^\s*(.+)\s*$/) {
	    my $d = $1;
	    if ($doc =~ m/[\)\`.:]$/) {
		$doc .= "\n$d";
	    } else {
		$doc .= " $d";
	    }
	}
    }
}
my $hash_name = "promql-mode-eldoc--functions";
print "(defvar $hash_name\n";
print "  (let ((tmp-hash-table (make-hash-table :test 'equal)))\n";

while ((my $function, my $v) = each(%docs)) {
    my $params = @$v[0];
    my $doc = @$v[1];
    print "    (puthash \"$function\" '($params) tmp-hash-table)\n";
}

print "    tmp-hash-table))\n";
