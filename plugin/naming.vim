

fun! g:smartNamingConvention(word)
  " is a delmiter-seperated name
  if a:word =~ '_'
	return naming#namingCS( a:word )

  " is a case-seperated name
  elseif a:word =~ '[A-Z]'
	return naming#namingDS( a:word )
  endif
  return a:word
endf


fun! s:vNamingConvention()
  let word = expand('<cword>')
  let new_word = g:smartNamingConvention(word)
  normal `<
  let pos1 = getpos('.')
  normal `>
  let pos2 = getpos('.')

  let line = getline('.')
  let line = strpart(line,0,pos1[2] - 1) . new_word . strpart(line,pos2[2])
  cal setline( '.' , line )
endf

fun! s:vNamingConventionGlobal()
  let word = expand('<cword>')
  exec printf('ConvertNamingConvention %s', word)
endf


fun! s:cConvertNamingConvention(line1,line2,from)
  let word = a:from
  let new_word = g:smartNamingConvention(word)
  let subcmd = printf('%d,%ds!%s\>!%s!g', a:line1 , a:line2 , word , new_word )
  exec subcmd
endf

vnoremap <silent> __ :cal <SID>vNamingConvention()<CR>
vnoremap <silent> _g :cal <SID>vNamingConventionGlobal()<CR>
com! -range=% -nargs=1 ConvertNamingConvention  :cal s:cConvertNamingConvention( <line1>, <line2>, <q-args> )
