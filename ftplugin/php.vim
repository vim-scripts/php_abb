" {{{ script header
"
" $Id: php.vim,v 1.4 2002/11/02 04:34:21 culley Exp culley $  
"
" ===========================================================================
" This is a vim ftplugin file for php.  My main goal in creating this file is
" to make my life easier.  If someone else can benefit from this stuff then
" great.  If you have a suggestion for improvement, please let me know at
" culley@ml1.net.
"
" The bulk of this file consists of maps and insert mode abbreviations that
" output php function and control structure stubs.  Each item begins with a
" heading similar to
"
"       PHP: function definition
"
" Function definitions where copied from the php manual.  To see a complete
" list if items grep on PHP:
"
"       grep "\"  PHP: " php.vim
"
" A good overview can also be seen by setting the foldmethod=marker.
"
" Each item should have an insert mode abbreviations prefixed by php. The
" print() function, for instance, has this abbreviation:  phpprint.  In
" addition to the full name of the function prefixed with php, I have usually
" also attempted to create an reasonable shortened version.  For print() this
" shortened version is phpp.  When it makes sense, abbreviations with the php
" prefix have additional output, such as a preceeding variable to make an
" expression and a semicolon to end the statement.
"
" When it makes sense, items will also have a normal and visual mode map.  For
" the print() function there are maps that will open up a new line and insert
" a print statement inclosing the variable name under the cursor when the map
" was executed.  Generally, the map should correspond to the shortened
" abbreviation prefixed by <leader>. The definition of each map should be
" broken up with <esc>a to avoid the double expansion of the item when
" non-prefix abbreviations are being used.
"
" Finally, for each item there should be a disabled abbreviation without any
" prefix.  When enabled these abbreviations (expanded by the space bar)
" complete the function syntax.  Typing print would output print(""); and
" leave the cursor between the quotation marks.  Not everyone is going to want
" these abbreviations so they are disabled.  To enable them execute this
" substitution command:
"
"       :%s/\("no-prefix: \)\(.*\)/\2 \1/gc
"
" To put the abbreviations back after they have been removed execute:
"
"       :%s/\(.*\) \("no-prefix:\)/\2 \1/gc
" 
" These abbreviations have also been gathered together in a separate file to
" be sourced at will if you don't want them permanently on.  The abbreviation
" without prefixes can really make things interesting if you can get used to
" it...
"
" Many of the function stubs require data entry in more than one location.
" For instance the implode function requires two parameters.  The <c-x>, <F7>
" and <leader>x maps are an attempt to help with this situation.  A
" placeholder (php~x) is inserted in positions 2..n of the function that
" require data entry.  The <c-x>, <F7> and <leader>x maps can then be used to
" advance to and replace these placeholders.  If this is too ugly for you or
" you just don't like the technique you can delete all the placeholders with:
"
"       :%s/php\~x//g
"
" The maps and abbreviations have been grouped into these sections:
"
"       - php functions
"       - php language constructs
"       - php predefined variables
"       - misc php stuff
"       - PEAR code snippets
"       - miscellaneous maps
"
" search for "Section:" to jump around.
" set fdm=marker for the folded version
"
" ===========================================================================
" }}}
" {{{ Section: php functions
" ===========================================================================
" Section: php functions 
" ===========================================================================

"  {{{ array_push
" ---------------------------------------------------------------------------
"  PHP: int array_push ( array array, mixed var [, mixed ...])
" ---------------------------------------------------------------------------
"  Map Comments:
"  when the cursor is on a php array variable use this map to open a 
"  new line below the cursor and insert an array_push function.
"
"  $test = array();                 //cursor is on test
"  array_push($test, <cursor>);     //this line will be inserted
"
" ---------------------------------------------------------------------------
nmap <leader>ap yiwoa<esc>array_push($<esc>pa, X);<esc>FXs
vmap <leader>ap yoa<esc>array_push($<esc>pa, X);<esc>FXs
iab phparray_push array_push($X, php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpap array_push($X, php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab array_push array_push($X, );<esc>FXs<c-o>:call getchar()<cr>
"}}}
"  {{{ array_key_exists
" ---------------------------------------------------------------------------
" PHP: bool array_key_exists ( mixed key, array search)
" ---------------------------------------------------------------------------
"""nmap <leader>ake yiwoa<esc>phpif array_key_exists('X', $<esc>pa)<esc>FXs<c-o>:call getchar()<cr>
"""vmap <leader>ake yoa<esc>array_key_exists('X', $<esc>pa)<esc>FXs<c-o>:call getchar()<cr>
iab phparray_key_exists array_key_exists('X', $php~x)<esc>FXs<c-o>:call getchar()<cr> 
iab phpake array_key_exists('X', $php~x)<esc>FXs<c-o>:call getchar()<cr>
iab phppke array_key_exists('X', $_POST)<esc>FXs<c-o>:call getchar()<cr>
iab phpcke array_key_exists('X', $_COOKIE)<esc>FXs<c-o>:call getchar()<cr>
iab phpgke array_key_exists('X', $_GET)<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab array_key_exists array_key_exists('X', $php~x)<esc>FXs<c-o>:call getchar()<cr>
"}}}
"  {{{ count
" ---------------------------------------------------------------------------
" PHP: int count ( mixed var)
" ---------------------------------------------------------------------------
nmap <leader>cnt yiwo$X = c<esc>aount($<esc>pa);<esc>FXs
vmap <leader>cnt yo$X = c<esc>aount($<esc>pa);<esc>FXs
iab phpcount $X = count($php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpcnt $X = count($php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab count count($X);<esc>FXs<c-o>:call getchar()<cr>
"}}}
"  {{{ echo
" ---------------------------------------------------------------------------
"  PHP: echo ( string arg1 [, string argn...])
" ---------------------------------------------------------------------------
nmap <leader>e yiwoe<esc>acho $<esc>pa;<esc>
vmap <leader>e yoe<esc>acho $<esc>pa;<esc>
iab phpecho echo "X";<esc>FXs<c-o>:call getchar()<cr>
iab phpe echo "X";<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab echo echo "X";<esc>FXs<c-o>:call getchar()<cr>
"// }}}
"  {{{ explode
" ---------------------------------------------------------------------------
"  PHP: array explode ( string separator, string string [, int limit])
" ---------------------------------------------------------------------------
"  Comments:
"  included the split function as it is an alias to explode
"  Map Comments:
"  when the cursor is on a php array variable use this map to open a 
"  new line below the cursor and insert the implode function
"
"  $test = array();            //cursor is on test
"  implode("<cursor>", $test); //this line will be inserted
"
" ---------------------------------------------------------------------------
nmap <leader>exp yiwoe<esc>axplode("X", $<esc>pa);<esc>FXs
vmap <leader>imp yoe<esc>axplode("X", $<esc>pa);<esc>FXs
iab phpexplode $X = explode('php~x', $php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpexp $X = explode('php~x', $php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpsplit $X = explode('php~x', $php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab explode explode('X', $php~x);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ extract
" ---------------------------------------------------------------------------
"  PHP: int extract ( array var_array [, int extract_type [, string prefix]])
" ---------------------------------------------------------------------------
"  Map Comments:
"  when the cursor is on a php array variable use this map to open a 
"  new line below the cursor and insert the extract function
"
"  $test = array();                //cursor is on test
"  extract($test, EXTR_OVERWRITE); //this line will be inserted
"  EXTR_OVERWRITE - If there is a collision, overwrite the 
"                   existing variable. (useful in for loop) 
"
" ---------------------------------------------------------------------------
nmap <leader>ext yiwoe<esc>axtract($<esc>pa, EXTR_OVERWRITE);<esc>
vmap <leader>ext yoe<esc>axtract($<esc>pa, EXTR_OVERWRITE);<esc>
iab phpextract extract($x, EXTR_OVERWRITE);<esc>Fxs<c-o>:call getchar()<cr>
iab phpext extract($x, EXTR_OVERWRITE);<esc>Fxs<c-o>:call getchar()<cr>
"no-prefix: iab extract extract($x, EXTR_OVERWRITE);<esc>Fxs<c-o>:call getchar()<cr>
" }}}
"  {{{ htmlspecialchars
"
" ---------------------------------------------------------------------------
" PHP: string htmlspecialchars ( string string [, int quote_style [, string charset]])
" ---------------------------------------------------------------------------
nmap <leader>hsc yiwo$<esc>pa = h<esc>atmlspecialchars($<esc>pa);<esc>
vmap <leader>hsc yo$<esc>pa = h<esc>atmlspecialchars($<esc>pa);<esc>
iab phphtmlspecialchars $X = htmlspecialchars($php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phphsc $X = htmlspecialchars($php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab htmlspecialchars htmlspecialchars($X);<esc>FXs<c-o>:call getchar()<cr>
"
" }}}
"  {{{ implode
" ---------------------------------------------------------------------------
"  PHP: string implode ( string glue, array pieces)
" ---------------------------------------------------------------------------
"  Comments:
"  included the join function as it is an alias to implode
"  Map Comments:
"  when the cursor is on a php array variable use this map to open a 
"  new line below the cursor and insert the implode function
"
"  $test = array();            //cursor is on test
"  implode("<cursor>", $test); //this line will be inserted
"
" ---------------------------------------------------------------------------
nmap <leader>imp yiwoi<esc>amplode("X", $<esc>pa);<esc>FXs
vmap <leader>imp yoi<esc>amplode("X", $<esc>pa);<esc>FXs
iab phpimplode $X = implode('php~x', $php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpimp $X = implode('php~x', $php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpjoin $X = implode('php~x', $php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab implode implode('X', $php~x);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ include
" ---------------------------------------------------------------------------
"  PHP: include_once()
"  PHP: include()
" ---------------------------------------------------------------------------
iab phpinclude_once include_once("X");<esc>FXs<c-o>:call getchar()<cr>
iab phpinc include_once("X");<esc>FXs<c-o>:call getchar()<cr>
iab phpinclude include("X");<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab include include("X");<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab include_once include_once("X");<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ isset
" ---------------------------------------------------------------------------
"  PHP: bool isset ( mixed var [, mixed var [, ...]])
" ---------------------------------------------------------------------------
iab phpisset isset($X)<esc>FXs<c-o>:call getchar()<cr>
iab phpiss isset($X)<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab isset isset($X)<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ preg_match
" ---------------------------------------------------------------------------
"  PHP: int preg_match ( string pattern, string subject [, array matches [, int flags]])
" ---------------------------------------------------------------------------
iab phppreg_match preg_match('/^X$/', $php~x, $matches)<esc>FXs<c-o>:call getchar()<cr>
iab phppm preg_match('/^X$/', $php~x, $matches)<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab preg_match preg_match('/^X$/', $php~x, $matches)<esc>Fxs<c-o>:call getchar()<cr>
" }}}
"  {{{ print
" ---------------------------------------------------------------------------
"  PHP: print ( string arg)
" ---------------------------------------------------------------------------
"  Map Comments:
"  when the cursor is on a php variable use these maps to open a new 
"  line and insert  print("$variable<br />");
"  useful for debugging
" ---------------------------------------------------------------------------

nmap <leader>pv yiwop<esc>arint("$<esc>pa<br />");<esc>
vmap <leader>pv yop<esc>arint("$<esc>pa<br />");<esc>
iab phpprint print("X");<esc>FXs<c-o>:call getchar()<cr>
iab phpp print("X");<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab print print("X");<esc>FXs<c-o>:call getchar()<cr>  
" }}}
"  {{{ print_r
" ---------------------------------------------------------------------------
"  PHP: void print_r ( mixed expression)
" ---------------------------------------------------------------------------
"  Map Comments:
"  when the cursor is on a php array variable use this map to open a 
"  new line below the cursor and insert a print_r function.
"  
"  $test = array(); //cursor is on test
"  print_r($test);  //this line will be inserted
"
" ---------------------------------------------------------------------------
nmap <leader>pr yiwop<esc>arint_r($<esc>pa);<esc>
vmap <leader>pr yop<esc>arint_r($<esc>pa);<esc>
iab phpprint_r print_r($X);<esc>FXs<c-o>:call getchar()<cr>
iab phppr print_r($X);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab print_r print_r($X);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ require
" ---------------------------------------------------------------------------
"  PHP: require()
"  PHP: require_once()
" ---------------------------------------------------------------------------
iab phprequire_once require_once("X");<esc>FXs<c-o>:call getchar()<cr>
iab phpreq require_once("X");<esc>FXs<c-o>:call getchar()<cr>
iab phprequire require("X");<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab require require("X");<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab require_once require_once("X");<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ strlen
" ---------------------------------------------------------------------------
"  PHP: int strlen ( string str)
" ---------------------------------------------------------------------------
nmap <leader>sl yiwos<esc>atrlen($<esc>pa)<esc>
vmap <leader>sl yos<esc>astlen($<esc>pa)<esc>
iab phpstrlen strlen($X)<esc>FXs<c-o>:call getchar()<cr>
iab phpstrl strlen($X)<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab strlen strlen($X)<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ strcmp
" ---------------------------------------------------------------------------
"  PHP: int strcmp ( string str1, string str2)
" ---------------------------------------------------------------------------
"  Comments:  I am always checking for a positive match so this function is
"             negated.
" ---------------------------------------------------------------------------
nmap <leader>sc yiwo!s<esc>atrcmp($<esc>pa, X)<esc>FXs
nmap <leader>sc yo!s<esc>atrcmp($<esc>pa, X)<esc>FXs
iab phpstrcmp strcmp($X, php~x)<esc>FXs<c-o>:call getchar()<cr>
iab phpsc strcmp($X, php~x)<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab strcmp strcmp($X, php~x)<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ strstr
" ---------------------------------------------------------------------------
" PHP: string strstr ( string haystack, string needle)
" ---------------------------------------------------------------------------
nmap <leader>strs yiwo$<esc>pa = s<esc>atrstr($<esc>pa, 'X');<esc>FXs
vmap <leader>strs yo$<esc>pa = s<esc>atrstr($<esc>pa, 'X');<esc>FXs
iab phpstrstr $X = strstr($php~x,'php~x');<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab strstr strstr($X, 'php~x');<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ strcasecmp
" ---------------------------------------------------------------------------
" PHP: int strcasecmp ( string str1, string str2)
" ---------------------------------------------------------------------------
"  Comments:  I am always checking for a positive match so this function is
"             negated.
" ---------------------------------------------------------------------------
nmap <leader>sc yiwo!s<esc>atrcasecmp($<esc>pa, "X")<esc>FXs
nmap <leader>sc yo!s<esc>atrcasecmp($<esc>pa, "X")<esc>FXs
iab phpstrcmp strcasecmp($X, "php~x")<esc>FXs<c-o>:call getchar()<cr>
iab phpsc strcasecmp($X, "php~x")<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab strcasecmp strcasecmp($X, "php~x")<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ str_replace
" ---------------------------------------------------------------------------
"  PHP: mixed str_replace ( mixed search, mixed replace, mixed subject)
" ---------------------------------------------------------------------------
nmap <leader>strr yiwo$<esc>pa = s<esc>atr_replace("X", "php~x", $<esc>pa);<esc>FXs<c-o>:call getchar()<cr>a
vmap <leader>strr yo$<esc>pa = s<esc>atr_replace("X", "php~x", $<esc>pa);<esc>FXs<c-o>:call getchar()<cr>a
iab phpstr_replace $X = str_replace("php~x", "php~x", $php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpstrr $X = str_replace("php~x", "php~x", $php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab str_replace str_replace("X", "php~x", $php~x);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ strtolower
" ---------------------------------------------------------------------------
"  PHP: string strtolower ( string str)
" ---------------------------------------------------------------------------
nmap <leader>strtl yiwo$<esc>pa = s<esc>atrtolower($<esc>pa);<esc>
vmap <leader>strtl yo$<esc>pa = s<esc>atrtolower($<esc>pa);<esc>
iab phpstrtolower $X = strtolower($php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpstrtl $X = strtolower($php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab strtolower strtolower($X);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ strtoupper
" ---------------------------------------------------------------------------
"  PHP: string strtoupper ( string str)
" ---------------------------------------------------------------------------
nmap <leader>strtl yiwo$<esc>pa = s<esc>atrtoupper($<esc>pa);<esc>
vmap <leader>strtl yo$<esc>pa = s<esc>atrtoupper($<esc>pa);<esc>
iab phpstrtoupper $X = strtoupper($php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpstrtu $X = strtoupper($php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab strtoupper strtoupper($X);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ substr
" ---------------------------------------------------------------------------
" PHP: string substr ( string string, int start [, int length])
" ---------------------------------------------------------------------------
nmap <leader>ss yiwo$<esc>pa = s<esc>aubstr($<esc>pa, X);<esc>FXs
vmap <leader>ss yo$<esc>pa = s<esc>aubstr($<esc>pa, X);<esc>FXs
iab phpsubstr $X = substr($php~x, php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpss $X = substr($php~x, php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab substr substr($php~x, php~x);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ trigger_error
" ---------------------------------------------------------------------------
" PHP: void trigger_error ( string error_msg [, int error_type])
" ---------------------------------------------------------------------------
nmap <leader>te yiwo t<esc>arigger_error(<esc>pa, E_USER_ERROR);<esc>
vmap <leader>ss yo t<esc>arigger_error(<esc>pa, E_USER_ERROR);<esc>
iab phptrigger_error trigger_error(X, E_USER_ERROR);<esc>FXs<c-o>:call getchar()<cr>
iab phpte trigger_error(X, E_USER_ERROR);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab trigger_error trigger_error(X, E_USER_ERROR);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ unset
" ---------------------------------------------------------------------------
"  PHP: void unset ( mixed var [, mixed var [, ...]])
" ---------------------------------------------------------------------------
nmap <leader>us yiwou<esc>anset($<esc>pa)<esc>
vmap <leader>us you<esc>anset($<esc>pa)<esc>
iab phpunset unset($X);<esc>FXs<c-o>:call getchar()<cr>
iab phpus unset($X);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab unset unset($X);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ wordwrap
" ---------------------------------------------------------------------------
"  PHP: string wordwrap ( string str [, int width [, string break [, int cut]]])
" ---------------------------------------------------------------------------
nmap <leader>ww yiwo$<esc>pa = w<esc>aordwrap($<esc>pa, X);<esc>FXs<c-o>:call getchar()<cr>a
vmap <leader>ww yo$<esc>pa = w<esc>aordwrap($<esc>pa, X);<esc>FXs<c-o>:call getchar()<cr>a
iab phpwordwrap $X = wordwrap($php~x, php~x);<esc>FXs<c-o>:call getchar()<cr>
iab phpww $X = wordwrap($php~x, php~x);<esc>FXs<c-o>:call getchar()<cr>
"no-prefix: iab wordwrap wordwrap($X, php~x);<esc>FXs<c-o>:call getchar()<cr>
" }}}
" }}}
" {{{ Section: php language constructs
"
" ===========================================================================
" Section: php language constructs 
" ===========================================================================

" ---------------------------------------------------------------------------
"  PHP: (expr1) ? (expr2) : (expr3);
"  PHP: if (expr) { statement }
"  PHP: if (expr) { statement } else { statements }
"  PHP: if (expr) { statement } elseif { statements } else { statements }
"  PHP: switch (expr) { case: }
"  PHP: for (expr1; expr2; expr3) statement
"  PHP: foreach(array_expression as $key => $value) statement
"  PHP: while (expr) statement
"  PHP: function foo ($arg_1, $arg_2, ..., $arg_n) { statements }
"  PHP: <?php ?>
"  PHP: <?= ?>
" ---------------------------------------------------------------------------
"  Comments: I always think of the ternary operator as shorthand for an
"  if-else statement.  So the "logic" behind the name of this abbreviation is
"  in thinking of it as the single line format of the if statement (if line or
"  ifl).  I can't think of a good way to do both versions of foreach so for
"  now I've only included the long version
"
"  Usage:  cintent setting should indent these properly after opening a line
" ---------------------------------------------------------------------------
iab phpifl $X = ($php~x) ? $php~x : $php~x;<esc>FXs<c-o>:call getchar()<cr>
iab phpif if ($X) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpife if ($X) {<cr>} else {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpifeif if ($X) {<cr>} elseif (php~x) {<cr>} else {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpswitch switch ($X) {<cr>Case $php~x:<cr>break;<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpfor for($i=0;$iX;$i++) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpfore foreach($X as $k => $v) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpwhile while ($X) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpfunc // {{{ function <cr>function X()<cr>{<cr><cr>}<cr>// }}}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phph <?php<cr>X<cr>?><esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpo <?= $X ?><esc>FXs<c-o>:call getchar()<cr>
iab phpclass class X {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>

"no-prefix: iab if if ($X) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"no-prefix: iab else else {<cr>X<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"no-prefix: iab elseif elseif ($X) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"no-prefix: iab switch switch ($X) {<cr>Case $php~x:<cr>break;<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"no-prefix: iab for for($i=0;$iX;$i++) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"no-prefix: iab foreach foreach($X as $k => $v) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"no-prefix: iab while while ($X) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"no-prefix: iab function // {{{ function <cr>function X()<cr>{<cr><cr>}<cr>// }}}<esc>?X<cr>s<c-o>:call getchar()<cr>
" }}}
" {{{ Section: php predefined variables
" ===========================================================================
" Section: php predefined variables
" ===========================================================================
"
iab phppost $_POST["X"]<esc>FXs<c-o>:call getchar()<cr>
iab phpget $_GET["X"]<esc>FXs<c-o>:call getchar()<cr>
iab phpsess $_SESSION["X"]<esc>FXs<c-o>:call getchar()<cr>
iab phpserver $_SERVER["X"]<esc>FXs<c-o>:call getchar()<cr>
iab phpself $_SERVER['PHP_SELF']<c-o>:call getchar()<cr>
iab phpcookie $_COOKIE['X']<esc>FXs<c-o>:call getchar()<cr>
"}}}
" {{{ Section: misc php stuff
" 
" ===========================================================================
" Section: misc php stuff
" ===========================================================================

"  {{{ phphtml
" ---------------------------------------------------------------------------
" phphtml Output:
" ---------------------------------------------------------------------------
"       ?>
"       <cursor>
"       <?php
" ---------------------------------------------------------------------------
" Usage: cut a hole in the php output for some html
" ---------------------------------------------------------------------------
iab phphtml ?><cr><?php<esc>O<c-o>:call getchar()<cr>
" }}}
"  {{{ phpsql
" ---------------------------------------------------------------------------
" phpsql Output:
" ---------------------------------------------------------------------------
"       $sql = "<cursor>";
" ---------------------------------------------------------------------------
iab phpsql $sql = "X";<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ phpid
" ---------------------------------------------------------------------------
" phpid Output:
" ---------------------------------------------------------------------------
"       // $Id$ <cursor> 
" ---------------------------------------------------------------------------
iab phpid // $Id$
" }}}
"  {{{ phpcom
" ---------------------------------------------------------------------------
" phpcom Output:  05-03-2003 switched this to ///
" ---------------------------------------------------------------------------
"       /**
"       * <cursor>
"       */
" ---------------------------------------------------------------------------
"iab phpcom /**<cr><bs>*<space>X<cr>*/<esc>?X<cr>s<c-o>:call getchar()<cr>
iab phpcom ///
" }}}
"  {{{ phploc
" ---------------------------------------------------------------------------
" phploc Output:
" ---------------------------------------------------------------------------
"       header("Location: <cursor>.php");
" ---------------------------------------------------------------------------
iab phploc header("Location: X.php");<cr>exit;<esc>?X<cr>s<c-o>:call getchar()<cr>
" }}}
"  {{{ phpes
" ---------------------------------------------------------------------------
" phpes Output:
" ---------------------------------------------------------------------------
"       echo "$sql<br />";<cursor>
" ---------------------------------------------------------------------------
" Usage: debugging tool-- see what sql was sent to the database
" ---------------------------------------------------------------------------
iab phpes echo "$sql<br />";<c-o>:call getchar()<cr>
" }}}
"  {{{ phplv
" ---------------------------------------------------------------------------
" phplv Output:
" ---------------------------------------------------------------------------
"       $sql = "select last_value from <cursor>"; 
"       $last_value = $dbh->getOne($sql);
" ---------------------------------------------------------------------------
" Usage: look up the last value from a postgresql sequence
" ---------------------------------------------------------------------------
iab phplv $sql = "select last_value from X";<esc>o$last_value = $dbh->getOne($sql);<esc>?X<cr>s<c-o>:call getchar()<cr>
" }}}
"  {{{ phptc
" ---------------------------------------------------------------------------
" phptc Output:
" ---------------------------------------------------------------------------
"       to_char(<cursor>, 'YYYY-MM-DD') as x
" ---------------------------------------------------------------------------
" Usage: this is actually a sql abbreviation.  output the postgresql
" date formating function to_char
" ---------------------------------------------------------------------------
iab phptc to_char(X, 'YYYY-MM-DD') as php~x<esc>?X<cr>s<c-o>:call getchar()<cr>
" }}}
"  {{{ phpfold
" ---------------------------------------------------------------------------
" phpfold Output:
" ---------------------------------------------------------------------------
" Usage: creates a vim fold behind php comments.
" ---------------------------------------------------------------------------
iab phpfold // {{{ X <cr>// }}}<esc>?X<cr>s<c-o>:call getchar()<cr>
" }}}
"  {{{ phptodo
" ---------------------------------------------------------------------------
" phptodo Output:
"       //TODO:
" ---------------------------------------------------------------------------
iab phptodo //TODO:
" }}}
" }}}
" {{{ Section: PEAR code snippets
"
" ===========================================================================
" Section: PEAR code snippets
" ===========================================================================

"  {{{ phpgc
" ---------------------------------------------------------------------------
" phpgc Output:
" ---------------------------------------------------------------------------
"       $dbh =& getConnection(ABC_DB_SITEADMIN);<cursor>
" ---------------------------------------------------------------------------
" Usage: not going to be very useful to most people.  This calls a
" function that returns a PEAR connection object.  ABC_DB_SITEADMIN
" is a constant...
" ---------------------------------------------------------------------------
iab phpgc $dbh =& getConnection(ABC_DB_SITEADMIN);<c-o>:call getchar()<cr>
" }}}
"  {{{ phpq
" ---------------------------------------------------------------------------
" phpq Output:
" ---------------------------------------------------------------------------
"       $dbh->query($sql);<cursor>
" ---------------------------------------------------------------------------
" Usage: execute query against a pear DB handle.  see phpsql
" ---------------------------------------------------------------------------
iab phpq $dbh->query($sql);<c-o>:call getchar()<cr>
" }}}
"  {{{ phpqr
" ---------------------------------------------------------------------------
" phpqr Output:
" ---------------------------------------------------------------------------
"       $result = $dbh->query($sql);
"
"       while ($row = $result->fetchRow()) {
"           $<cursor> = $row['php~x'];
"       }
" ---------------------------------------------------------------------------
" Usage: return output for looping through a pear DB resultset
" ---------------------------------------------------------------------------
iab phpqr $result = $dbh->query($sql);<cr><cr>while ($row = $result->fetchRow()) {<cr>$X = $row['php~x'];<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
" }}}
"  {{{ phpgo
" ---------------------------------------------------------------------------
" phpgo Output:
" ---------------------------------------------------------------------------
"       $<cursor> = $dbh->getOne($sql);
" ---------------------------------------------------------------------------
iab phpgo $X = $dbh->getOne($sql);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ phpgr
" ---------------------------------------------------------------------------
" phpgr Output:
" ---------------------------------------------------------------------------
"       $data = $dbh->getRow($sql);<cursor>
" ---------------------------------------------------------------------------
iab phpgr $data = $dbh->getRow($sql);<c-o>:call getchar()<cr>
" }}}
"  {{{ phpgcol
" ---------------------------------------------------------------------------
" phpgcol Output:
" ---------------------------------------------------------------------------
"       $dbh->getCol($sql);<cursor>
" ---------------------------------------------------------------------------
iab phpgcol $data = $dbh->getCol($sql);<c-o>:call getchar()<cr>
" }}}
"  {{{ phpga
" ---------------------------------------------------------------------------
" phpga Output:
" ---------------------------------------------------------------------------
"       $data = $dbh->getAll($sql);
" ---------------------------------------------------------------------------
iab phpga $data = $dbh->getAll($sql);<c-o>:call getchar()<cr>
" }}}
"  {{{ phpgassoc
" ---------------------------------------------------------------------------
" phpgassoc Output:
" ---------------------------------------------------------------------------
"       $data = $dbh->getAssoc($sql);
" ---------------------------------------------------------------------------
iab phpgassoc $data = $dbh->getAssoc($sql);<c-o>:call getchar()<cr>
" }}}
"  {{{ phprow
" ---------------------------------------------------------------------------
" phprow Output:
" ---------------------------------------------------------------------------
"       $row["<cursor>"];
" ---------------------------------------------------------------------------
iab phprow $row["X"];<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ phpnr
" ---------------------------------------------------------------------------
" *UPDATE phpnr Output:
" ---------------------------------------------------------------------------
"       $result->numRows();<cursor>
" ---------------------------------------------------------------------------
iab phpnr $X = $result->numRows();<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ phpni
" ---------------------------------------------------------------------------
" phpni Output:
" ---------------------------------------------------------------------------
"       $X = $dbh->nextId('php~x', false);<cursor>
" ---------------------------------------------------------------------------
iab phpni $X = $dbh->nextId('php~x', false);<esc>FXs<c-o>:call getchar()<cr>
" }}}
"  {{{ phptbl
" ---------------------------------------------------------------------------
" phptbl Output:
" ---------------------------------------------------------------------------
"       $table = new HTML_Table(ABC_TBL_ATTRIBUTES);
" ---------------------------------------------------------------------------
" Usage: create a new PEAR table object replace ABC_TBL_ATTRIBUTES 
" with your favorite table attributes.
" ---------------------------------------------------------------------------
iab phptbl $table =& new HTML_Table(ABC_TBL_ATTRIBUTES);<c-o>:call getchar()<cr>
" }}}
"  {{{ phptblr
" ---------------------------------------------------------------------------
" phptblr Output:
" ---------------------------------------------------------------------------
"       $table->addRow(array(<cursor>));
" ---------------------------------------------------------------------------
" Usage: you probably would want to replace ABC_TBL_SHADEDROW with your
" favorite attributes
" ---------------------------------------------------------------------------
iab phptblr $table->addRow(array(X), ABC_TBL_SHADEDROW);<esc>?X<cr>s<c-o>:call getchar()<cr>
" }}}
"  {{{ phptbld & phptblh
" ---------------------------------------------------------------------------
" phptbld Output:
" phptblh Output:
" ---------------------------------------------------------------------------
"       $table->display();
"       $table->toHTML();
" ---------------------------------------------------------------------------
iab phptbld $table->display();<c-o>:call getchar()<cr>
iab phptblh $table->toHTML();<c-o>:call getchar()<cr>
" }}}
"
" }}}
" {{{ Section: miscellaneous maps
"
" ===========================================================================
" Section: miscellaneous maps
" ===========================================================================

" ---------------------------------------------------------------------------
" visual map to insert a vim fold in php comments
" ---------------------------------------------------------------------------
vmap    <leader>fold mz:<ESC>'<O// {{{<ESC>'>o// }}}<ESC>`z?{{{<cr>A<space>

" ---------------------------------------------------------------------------
"  These maps are used to deal with the place holders set in the various
"  function stubs.  control+x will go forward and substitue out the next
"  occurance of php~x.  Ditto for <leader>x in normal mode and <F7> in insert
"  and normal mode.
" ---------------------------------------------------------------------------
nmap    <leader>x /php\~x<cr>vwwc
imap    <c-x>     <esc>/php\~x<cr>vwwc
imap    <F7>      <esc>/php\~x<cr>vwwc
nmap    <F7>      <esc>/php\~x<cr>vwwc
nmap    <c-x>     /php\~x<cr>vwwc
"}}}

