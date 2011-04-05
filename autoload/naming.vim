" naming to case-seperated name
fun! naming#namingCS(word)
  return substitute( a:word , '_\([a-z]\)' , '\U\1' , 'g' )
endf

" naming to delmiter-seperated name
fun! naming#namingDS(word)
  return substitute( a:word , '\([A-Z]\)' , '_\L\1' , 'g' )
endf

