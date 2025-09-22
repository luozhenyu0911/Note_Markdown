











# 变量赋值
my $name = "junmajinlong";
print "$name\n";
# 为数组元素赋值
my @arr;
$arr[0] = "junmajinlong";

# 为hash元素赋值
my %person;
$person{name} = "junmajinlong";

# 对某些函数调用的返回结果赋值
my $name = 'jun';
substr($name, 3) = 'ma';

print "$name\n";

substr($name, 2) = 'ma';

print "$name\n";



use feature qw(say);
(my $name = "junmajinlong") =~ s/j/J/;
say "$name";   # 输出：Junmajinlong

(my $name = "junmajinlong") =~ s/j/J/g;
say "$name";   # 输出：Junmajinlong


Install all modules with prefix ~/perl5 
cpanm -L ~/perl5 Config::General


Set @INC to includ that when running your program, for example:
perl -I ~/perl5/lib/perl5 test.pl

export PERL5LIB=/BIGDATA2/gzfezx_shhli_2/miniconda3/envs/SVDetect/lib/perl5/site_perl::$PERL5LIB

















































