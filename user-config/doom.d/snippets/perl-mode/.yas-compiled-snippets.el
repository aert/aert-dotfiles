;;; Compiled snippets and support files for `perl-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'perl-mode
                     '(("xwh" "${1:expression} while ${2:condition};" "xwh" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/xwh" nil nil)
                       ("xunless" "${1:expression} unless ${2:condition};" "xunless" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/xunless" nil nil)
                       ("xif" "${1:expression} if ${2:condition};" "xif" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/xif" nil nil)
                       ("xfor" "${1:expression} for @${2:array};" "xfor" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/xfor" nil nil)
                       ("when" "when (${1:case}) {\n  $0\n}\n" "when" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/when" nil nil)
                       ("wh" "while ($1) {\n  $0\n}" "wh" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/wh" nil nil)
                       ("vers" "## no critic\nour $VERSION = '${0:version}';\neval $VERSION;\n## use critic" "vers" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/vers" nil nil)
                       ("unless" "unless ($1) {\n  $0\n}" "unless" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/unless" nil nil)
                       ("tuse" "use Test::More;\nuse Test::Deep; # (); # uncomment to stop prototype errors\nuse Test::Exception;\n" "tuse" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/tuse" nil nil)
                       ("tsub" "sub t${1:number}_${2:test_case} :Test(${3:num_of_tests}) {\n  my $self = shift;\n  $0\n\n}\n" "tsub" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/tsub" nil nil)
                       ("trunner" "use ${0:test_class};\n$1->runtests();\n" "trunner" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/trunner" nil nil)
                       ("trsub" "test ${1:test_name} => { description => '${2:Description of test.}'} => sub {\n  my ($self) = @_;\n  $0\n};\n" "trsub" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/trsub" nil nil)
                       ("tprep" "sub prep${1:number}_${2:test_case} :Test(startup) {\n  my $self = shift;\n  $0\n}\n" "tprep" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/tprep" nil nil)
                       ("tmeths" "$ENV{TEST_METHOD} = '${0:regex}';\n" "tmeths" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/tmeths" nil nil)
                       ("tlib" "use lib qw{ ./t/lib };\n" "tlib" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/tlib" nil nil)
                       ("switch" "use feature 'switch';\n" "switch" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/switch" nil nil)
                       ("subtest" "subtest '${1: test_name}' => sub {\n  $2\n};" "subtest" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/subtest" nil nil)
                       ("subpod" "=head2 $1\n\nSummary of $1\n\n=cut\n\nsub ${1:subroutine_name} {\n  $0\n}" "subpod" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/subpod" nil nil)
                       ("sub" "sub ${1:function_name} {\n  $0\n}" "sub" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/sub" nil nil)
                       ("strwar" "use strict;\nuse warnings;" "strwar" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/strwar" nil nil)
                       ("slurp" "my $${1:var} = do { local $/; open my $file, '<', \"${2:file}\"; <$file> };\n$0" "slurp" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/slurp" nil nil)
                       ("qrx" "qr/\n     ${0:regex}\n/xms\n" "qrx" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/qrx" nil nil)
                       ("qr/" "qr/${0:regex}/x\n" "qr/" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/qr_" nil nil)
                       ("psubi" "=head2 ${1:MethodName}\n\n${0:Summary...}\n\n\n=cut" "psubi" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/psubi" nil nil)
                       ("psub" "=head2 ${1:MethodName}\n\n${0:Summary....}\n" "psub" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/psub" nil nil)
                       ("ppod" "=head1 NAME\n\n${1:ClassName} - ${2:ShortDesc}\n\n=head1 SYNOPSIS\n\n  use $1;\n\n  ${3:# synopsis...}\n\n=head1 DESCRIPTION\n\n${0:# longer description...}\n\n\n=head1 INTERFACE\n\n\n=head1 DEPENDENCIES\n\n\n=head1 SEE ALSO\n\n" "ppod" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/ppod" nil nil)
                       ("pkgmv" "__PACKAGE__->${1:package_method}(${0:var})\n" "pkgmv" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/pkgmv" nil nil)
                       ("pkgm" "__PACKAGE__->${0:package_method}()\n" "pkgm" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/pkgm" nil nil)
                       ("pkgetv" "__PACKAGE__->get_${1:package_method}(${0:var})\n" "pkgetv" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/pkgetv" nil nil)
                       ("pkget" "__PACKAGE__->get_${0:package_method}()\n" "pkget" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/pkget" nil nil)
                       ("parg" "=over 2\n\n=item\nArguments\n\n\n=over 3\n\n=item\nC<${1:DataStructure}>\n\n  ${2:Sample}\n\n\n=back\n\n\n=item\nReturn\n\n=over 3\n\n\n=item\nC<${0:...return data}>\n\n\n=back\n\n\n=back\n\n\n" "parg" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/parg" nil nil)
                       ("parent" "use parent qw(${0:Parent Class});" "parent" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/parent" nil nil)
                       ("packagev514" "package ${1:} ${2:0.99};\nuse v5.14;\nuse warnings;\n\n$0\n\n1;\n\n__END__" "packagev514" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/packagev514" nil nil)
                       ("package" "package ${1:};\nuse strict;\nuse warnings;\n\n$0\n\n1;\n\n__END__" "package" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/package" nil nil)
                       ("override" "override ${1:attribute} => sub {\n  ${2:# my $self = shift;};\n  ${0:# my ($self, $args) = @_;};\n};\n\n" "override" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/override" nil nil)
                       ("moose" "use Moose;\nuse namespace::autoclean;\n${1:#}BEGIN {extends '${2:ParentClass}'};\n\n$0" "moose" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/moose" nil nil)
                       ("map" "map {  ${0: body }    }  ${1: @array } ;\n\n\n" "map" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/map" nil nil)
                       ("ifee" "if ($1) {\n  $2\n}\nelsif ($3) {\n  ${4:# elsif...}\n}\nelse {\n  $0\n}" "ifee" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/ifee" nil nil)
                       ("ife" "if ($1) {\n  $2\n}\nelse {\n  $0\n}" "ife" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/ife" nil nil)
                       ("if" "if ($1) {\n  $0\n}" "if" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/if" nil nil)
                       ("hslice" "@{ ${1:hash}  }{ ${0:array} }\n\n" "hslice" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/hslice" nil nil)
                       ("has" "has ${1:attribute} => (\n  is	    => '${2:ro|rw}',\n  isa 	=> '${3:Str|Int|HashRef|ArrayRef|etc}',\n  default => sub {\n  	${4:defaultvalue}\n  },\n  ${0:# other attributes}\n);\n\n" "has" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/has" nil nil)
                       ("given" "given ($${1:var}) {\n  ${2:# cases}\n  ${0:# default}\n}\n" "given" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/given" nil nil)
                       ("fore" "${1:expression} foreach @${2:array};" "fore" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/fore" nil nil)
                       ("for" "foreach my $${1:x} (@${2:array}) {\n  $0\n}" "for" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/for" nil nil)
                       ("eval" "local $@;\neval {\n  ${1:# do something risky...}\n};\nif (my $e = $@) {\n  ${0:# handle failure...}\n}" "eval" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/eval" nil nil)
                       ("eif" "elsif ($1) {\n  $0\n}" "eif" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/eif" nil nil)
                       ("dump" "use Data::Dump qw(dump);\nwarn dump ${1:variable}\n" "dump" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/dump" nil nil)
                       ("debug_trace" "use Carp; # 'verbose';\n# cloak \"die\"\n# warn \"warning\"\n$SIG{'__DIE__'} = sub {\n  require Carp; Carp::confess\n};\n" "debug_trace" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/debug_trace" nil nil)
                       ("cfor" "for (my $${2:var} = 0; $$2 < ${1:count}; $$2${3:++}) {\n  $0\n}" "cfor" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/cfor" nil nil)
                       ("begin" "BEGIN {\n  $0\n}\n" "begin" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/begin" nil nil)
                       ("asub" "sub {\n  $0\n}\n\n\n" "asub" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/asub" nil nil)
                       ("." "=>" "." nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/_" nil nil)
                       ("#!" "#!/usr/bin/env perl\n" "#!" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/perl-mode/#!" nil nil)))


;;; Do not edit! File generated at Mon May  8 02:40:51 2017