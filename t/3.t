
use Test::More tests => 9;

BEGIN {use_ok('Tree::Numbered') };
BEGIN {use_ok('SideBar') };

my $max_level = 3;

my $tree = Tree::Numbered->new('Root');
my $child = $tree->append(value => "First");
$tree->append(value => "Second");
$child->append(value => "First child");

HTML::Widget::SideBar->convert(tree => $tree);
isa_ok($tree, "HTML::Widget::SideBar", "convert");

ok($child = $tree->append("Something", '0'), "appending");
is ($child->getAction, $tree->getAction, "assigning default action");
isnt($child->getUniqueId, $tree->getUniqueId, "UniqueId is different");

my @lines = $tree->getHTML;
is ($#lines, $max_level*3 + $tree->listChildNumbers - $tree->childCount, "all HTML produced");

