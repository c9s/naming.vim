
" getConfig

" naming to case-seperated name
fun! s:namingCS(word)
  return substitute( a:word , '_\([a-z]\)' , '\U\1' , 'g' )
endf

" naming to delmiter-seperated name
fun! s:namingDS(word)
  return substitute( a:word , '\([A-Z]\)' , '_\L\1' , 'g' )
endf


fun! s:smartConvention(word)
  " is a delmiter-seperated name
  if a:word =~ '_'
	return s:namingCS( a:word )

  " is a case-seperated name
  elseif a:word =~ '[A-Z]'
	return s:namingDS( a:word )

  endif
  return a:word
endf


fun! s:vNamingConvention()
  let word = expand('<cword>')
  let new_word = s:smartConvention(word)

  normal `<
  let pos1 = getpos('.')
  normal `>
  let pos2 = getpos('.')

  let line = getline('.')
  let line = strpart(line,0,pos1[2] - 1) . new_word . strpart(line,pos2[2])
  cal setline( '.' , line )
endf

fun! s:cConvertNamingConvention(line1,line2,from)
  let word = a:from
  let new_word = s:smartConvention(word)
  let subcmd = printf('%d,%ds!%s\>!%s!g', a:line1 , a:line2 , word , new_word )
  exec subcmd
endf

vnoremap <silent> _ :cal <SID>vNamingConvention()<CR>
com! -range=% -nargs=1 ConvertNamingConvention  :cal s:cConvertNamingConvention( <line1>, <line2>, <q-args> )
