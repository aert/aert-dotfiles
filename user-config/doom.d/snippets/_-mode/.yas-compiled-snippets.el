;;; Compiled snippets and support files for `_-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets '_-mode
                     '(("time" "`(format-time-string \"%H:%M\")`" "time" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/time" nil nil)
                       ("lorem" "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." "lorem" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/lorem" nil nil)
                       ("diso" "`(concat (format-time-string \"%Y-%m-%dT%H:%M:%S\") ((lambda (x) (concat (substring x 0 3) \":\" (substring x 3 5))) (format-time-string \"%z\")))`" "diso" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/diso" nil nil)
                       ("ddate" "`(format-time-string \"%B %d, %Y\")`" "ddate" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/ddate" nil nil)
                       ("datetime" "`(format-time-string \"%Y-%m-%d %H:%M\")`" "datetime" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/datetime" nil nil)
                       ("date" "`(format-time-string \"%Y-%m-%d\")`" "date" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/date" nil nil)
                       ("c)" "Copyright  `(format-time-string \"%Y\")` ${1:`\"Name\"`}. All Rights Reserved." "c)" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/c)" nil nil)
                       ("WTFPL" "DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE\n  	Version 2, December 2004\n\n  Copyright `(format-time-string \"%Y\")` ${0:`\"Name\"`}\n\n  Everyone is permitted to copy and distribute verbatim or modified\n  copies of this license document, and changing it is allowed as long\n  as the name is changed.\n\nDO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE\n  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION\n\n   0. You just DO WHAT THE FUCK YOU WANT TO.\n\n  $0" "WTFPL" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/WTFPL" nil nil)
                       ("MPL2" "This Source Code Form is subject to the terms of the Mozilla Public\nLicense, v. 2.0. If a copy of the MPL was not distributed with this\nfile, You can obtain one at http://mozilla.org/MPL/2.0/.\n$0" "MPL2" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/MPL2" nil nil)
                       ("MIT" "${1:one line to give the program's name and a brief description}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nPermission is hereby granted, free of charge, to any person obtaining\na copy of this software and associated documentation files (the \"Software\"),\nto deal in the Software without restriction, including without limitation\nthe rights to use, copy, modify, merge, publish, distribute, sublicense,\nand/or sell copies of the Software, and to permit persons to whom the\nSoftware is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included\nin all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,\nEXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES\nOF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\nIN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,\nDAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\nTORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE\nOR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n$0" "MIT" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/MIT" nil nil)
                       ("LGPL3" "${1:One line to give the program's name and a brief description.}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nThis library is free software; you can redistribute it and/or modify\nit under the terms of the GNU Lesser General Public License as published\nby the Free Software Foundation; either version 3 of the License, or\n(at your option) any later version.\n\nThis library is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the\nGNU Lesser General Public License for more details.\n\nYou should have received a copy of the GNU Lesser General Public License\nalong with this library; if not, see <http://www.gnu.org/licenses/>.\n$0" "LGPL3" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/LGPL3" nil nil)
                       ("LGPL2" "${1:One line to give the program's name and a brief description.}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nThis library is free software; you can redistribute it and/or modify\nit under the terms of the GNU Lesser General Public License as published\nby the Free Software Foundation; either version 2.1 of the License, or\n(at your option) any later version.\n\nThis library is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the\nGNU Lesser General Public License for more details.\n\nYou should have received a copy of the GNU Lesser General Public License\nalong with this library; if not, see <http://www.gnu.org/licenses/>.\n$0" "LGPL2" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/LGPL2" nil nil)
                       ("ISC" "${1:one line to give the program's name and a brief description}\nCopyright  `(format-time-string \"%Y\")`, ${2:`\"Name\"`}\n\nPermission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.\n$0" "ISC" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/ISC" nil nil)
                       ("GPL3" "${1:one line to give the program's name and a brief description.}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation, either version 3 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program.  If not, see <http://www.gnu.org/licenses/>.\n$0" "GPL3" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/GPL3" nil nil)
                       ("GPL2" "${1:One line to give the program's name and a brief description.}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nThis program is free software; you can redistribute it and/or modify\nit under the terms of the GNU General Public License as published by\nthe Free Software Foundation; either version 2 of the License, or\n(at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the\nGNU General Public License for more details.\n\nYou should have received a copy of the GNU General Public License\nalong with this program; if not, see <http://www.gnu.org/licenses/>.\n$0" "GPL2" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/GPL2" nil nil)
                       ("GMGPL" "As a special exception, if other files instantiate generics from\nthis unit, or you link this unit with other files to produce an\nexecutable, this unit does not by itself cause the resulting\nexecutable to be covered by the GNU General Public License.\nThis exception does not however invalidate any other reasons why the\nexecutable file might be covered by the GNU Public License.\n\n$0" "linking exception" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/GMGPL" nil nil)
                       ("BSD4" "${1:one line to give the program's name and a brief description}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\nAll rights reserved.\n\nRedistribution and use in source and binary forms, with or without\nmodification, are permitted provided that the following conditions are met:\n1. Redistributions of source code must retain the above copyright\nnotice, this list of conditions and the following disclaimer.\n2. Redistributions in binary form must reproduce the above copyright\nnotice, this list of conditions and the following disclaimer in the\ndocumentation and/or other materials provided with the distribution.\n3. All advertising materials mentioning features or use of this software\nmust display the following acknowledgement:\nThis product includes software developed by the ${3:organization}.\n4. Neither the name of the $3 nor the\nnames of its contributors may be used to endorse or promote products\nderived from this software without specific prior written permission.\n\nTHIS SOFTWARE IS PROVIDED BY $2 ''AS IS'' AND ANY\nEXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\nWARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\nDISCLAIMED. IN NO EVENT SHALL $2 BE LIABLE FOR ANY\nDIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;\nLOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND\nON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS\nSOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n$0" "BSD4" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/BSD4" nil nil)
                       ("BSD3" "${1:one line to give the program's name and a brief description}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\nAll rights reserved.\n\nRedistribution and use in source and binary forms, with or without\nmodification, are permitted provided that the following conditions are met:\n1. Redistributions of source code must retain the above copyright\nnotice, this list of conditions and the following disclaimer.\n2. Redistributions in binary form must reproduce the above copyright\nnotice, this list of conditions and the following disclaimer in the\ndocumentation and/or other materials provided with the distribution.\n3. Neither the name of the ${3:organization} nor the\nnames of its contributors may be used to endorse or promote products\nderived from this software without specific prior written permission.\n\nTHIS SOFTWARE IS PROVIDED BY $2 ''AS IS'' AND ANY\nEXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\nWARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\nDISCLAIMED. IN NO EVENT SHALL $2 BE LIABLE FOR ANY\nDIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;\nLOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND\nON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS\nSOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n$0" "BSD3" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/BSD3" nil nil)
                       ("BSD2" "${1:one line to give the program's name and a brief description}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\nAll rights reserved.\n\nRedistribution and use in source and binary forms, with or without\nmodification, are permitted provided that the following conditions are met:\n1. Redistributions of source code must retain the above copyright\nnotice, this list of conditions and the following disclaimer.\n2. Redistributions in binary form must reproduce the above copyright\nnotice, this list of conditions and the following disclaimer in the\ndocumentation and/or other materials provided with the distribution.\n\nTHIS SOFTWARE IS PROVIDED BY $2 ''AS IS'' AND ANY\nEXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED\nWARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE\nDISCLAIMED. IN NO EVENT SHALL $2 BE LIABLE FOR ANY\nDIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES\n(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;\nLOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND\nON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT\n(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS\nSOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.\n\n\nThe views and conclusions contained in the software and documentation\nare those of the authors and should not be interpreted as representing\nofficial policies, either expressedor implied, of $2.\n$0" "BSD2" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/BSD2" nil nil)
                       ("BEERWARE" "${1:one line to give the program's name and a brief description}\nCopyright `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nLicensed under the \"THE BEER-WARE LICENSE\" (Revision 42):\n$2 wrote this file. As long as you retain this notice you\ncan do whatever you want with this stuff. If we meet some day, and you think\nthis stuff is worth it, you can buy me a beer or coffee in return\n$0" "BEERWARE" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/BEERWARE" nil nil)
                       ("APACHE" "${1:one line to give the program's name and a brief description}\nCopyright `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nLicensed under the Apache License, Version 2.0 (the \"License\");\nyou may not use this file except in compliance with the License.\nYou may obtain a copy of the License at\n\n  http://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software\ndistributed under the License is distributed on an \"AS IS\" BASIS,\nWITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\nSee the License for the specific language governing permissions and\nlimitations under the License.\n$0" "APACHE" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/APACHE" nil nil)
                       ("AGPL3" "${1:one line to give the program's name and a brief description.}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nThis program is free software: you can redistribute it and/or modify\nit under the terms of the GNU Affero General Public License as\npublished by the Free Software Foundation, either version 3 of the\nLicense, or (at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU Affero General Public License for more details.\n\nYou should have received a copy of the GNU Affero General Public License\nalong with this program.  If not, see <http://www.gnu.org/licenses/>.\n$0" "AGPL3" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/AGPL3" nil nil)
                       ("AGPL" "${1:One line to give the program's name and a brief description.}\nCopyright  `(format-time-string \"%Y\")` ${2:`\"Name\"`}\n\nThis program  is free software: you can redistribute it and/or modify\nit under the terms of the GNU Affero General Public License as\npublished by the Free Software Foundation, either version 3 of the\nLicense, or (at your option) any later version.\n\nThis program is distributed in the hope that it will be useful,\nbut WITHOUT ANY WARRANTY; without even the implied warranty of\nMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\nGNU Affero General Public License for more details.\n\nYou should have received a copy of the GNU Affero General Public License\nalong with this program. If not, see <http://www.gnu.org/licenses/>." "AGPL" nil nil nil "/home/bruno/code/yasnippet-vim-snippets/snippets/_-mode/AGPL" nil nil)))


;;; Do not edit! File generated at Mon May  8 02:40:49 2017