iab array_push array_push($X, );<esc>FXs<c-o>:call getchar()<cr>
iab echo echo "X";<esc>FXs<c-o>:call getchar()<cr>
iab explode explode('X', $php~x);<esc>FXs<c-o>:call getchar()<cr>
iab extract extract($x, EXTR_OVERWRITE);<esc>Fxs<c-o>:call getchar()<cr>
iab implode implode('X', $php~x);<esc>FXs<c-o>:call getchar()<cr>
iab include include("X");<esc>FXs<c-o>:call getchar()<cr>
iab include_once include_once("X");<esc>FXs<c-o>:call getchar()<cr>
iab isset isset($X)<esc>FXs<c-o>:call getchar()<cr>
iab preg_match preg_match('/^X$/', $php~x, $matches)<esc>Fxs<c-o>:call getchar()<cr>
iab print print("X");<esc>FXs<c-o>:call getchar()<cr>  
iab print_r print_r("$X");<esc>FXs<c-o>:call getchar()<cr>
iab require require("X");<esc>FXs<c-o>:call getchar()<cr>
iab require_once require_once("X");<esc>FXs<c-o>:call getchar()<cr>
iab strlen strlen($X)<esc>FXs<c-o>:call getchar()<cr>
iab strcmp !strcmp($X, "php~x")<esc>FXs<c-o>:call getchar()<cr>
iab str_replace str_replace("X", "php~x", $php~x);<esc>FXs<c-o>:call getchar()<cr>
iab strtolower strtolower($X);<esc>FXs<c-o>:call getchar()<cr>
iab strtoupper strtoupper($X);<esc>FXs<c-o>:call getchar()<cr>
iab unset unset($X);<esc>FXs<c-o>:call getchar()<cr>
iab wordwrap wordwrap($X, php~x);<esc>FXs<c-o>:call getchar()<cr>
"iab if if ($X) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab else else {<cr>X<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab elseif elseif ($X) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab switch switch ($X) {<cr>Case $php~x:<cr>break;<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"iab for for($i=0;$iX;$i++) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab foreach foreach($X as $k => $v) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
"iab while while ($X) {<cr>}<esc>?X<cr>s<c-o>:call getchar()<cr>
iab function // {{{ function <cr>function X()<cr>{<cr><cr>}<cr>// }}}<esc>?X<cr>s<c-o>:call getchar()<cr>
