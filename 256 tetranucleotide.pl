# !usr/bin/perl

use strict;
use warnings;
use 5.010;
use Data::Dumper qw(Dumper);

my $list = [
    ['a','c','g','t'],
    ['a','c','g','t'],
    ['a','c','g','t'],
    ['a','c','g','t'],
];

my $str_list = create($list);
$a=$str_list;
print $a;

sub create {
    my ($list) = @_;
    # 初始化序列
    my $str_list = [ '' ];
    foreach my $ref (@{$list}) {
        $str_list = create_list($str_list, $ref);
    }
    return $str_list;
}

# 根据列表创建列表
sub create_list {
    my ($ref_str_list, $ref_array) = @_;
    my @return_array;
    foreach my $str (@{$ref_str_list}) {
        foreach my $element (@{$ref_array}) {
            push @return_array, "${str}$element";
        }
    }
    return \@return_array;
}
