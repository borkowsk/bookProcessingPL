s|break\s*\;|pass|
s|^(\s*)default\s*\:|\1else :|
$!N
s|^(\s*)else(\s*):(\s*)\n(\s*)if|\1elif|
s|^(\s*)switch\((.*)\)(.*)\n(\s*)case(\s*)(.*):|\1_switchvar=\2 \3\n\4if  _switchvar==\5\6:|
s/(\s*)if(.*)\:\s*\n(\s*)case(.*)\:/\1if \2 or _switchvar==\4 :/g
s/(\s*)case(.*)\:\s*\n(\s*)case(.*)\:/\1elif _switchvar==\2 or _switchvar==\4 :/g
s|^(\s*)case(\s*)(.*):|\1elif\2_switchvar==\3:|
P
D

