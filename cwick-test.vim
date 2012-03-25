function! s:ExecWithClear(command)
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo

  exec a:command
endfunction

function! s:RunRSpec()
  call s:ExecWithClear(":!rspec --color")
  let s:cwick_test = "s:RunRSpec"
endfunction

function! s:RunCucumber()
  if filereadable("script/cucumber")
    let cucumber_cmd = "script/cucumber"
  else
    let cucumber_cmd = "cucumber"
  endif

  call s:ExecWithClear(":!" . cucumber_cmd)
  let s:cwick_test = "s:RunCucumber"
endfunction

function! s:UnknownTest()
  echo "Sorry, I don't know how to test " . expand("%")
endfunction

function! s:RunLastTest()
  if !exists("s:cwick_test")
    let s:cwick_test = "s:UnknownTest"
  endif

  call function(s:cwick_test)()
endfunction

function! RunTests()
  :wa
  let current_file = expand("%")

  if match(current_file, '\.feature$') != -1
    call s:RunCucumber()
  elseif match(current_file, '_spec.rb$') != -1
    call s:RunRSpec()
  else
    call s:RunLastTest()
  end
endfunction

