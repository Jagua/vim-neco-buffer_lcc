let s:save_cpo = &cpo
set cpo&vim


let s:source = {
      \ 'name' : 'buffer_lcc',
      \ 'kind' : 'manual',
      \ 'mark' : '[LCC]',
      \ 'rank' : 4,
      \ 'min_pattern_length' : g:neocomplete#auto_completion_start_length,
      \}


function! s:source.gather_candidates(context) abort "{{{
  let candidates = []
  let _ctx = neocomplete#get_current_neocomplete().sources.buffer.neocomplete__context
  let keywords = _ctx.candidates + _ctx.prev_candidates
  call filter(keywords, 'match(v:val, "^\\a\\+$") == 0')
  for keyword in keywords
    let ml = matchlist(keyword, '^\(\u\l\+\)\(\a*\)$')
    if !empty(ml) && len(ml) > 1
      call add(candidates, tolower(ml[1]) . ml[2])
    endif
  endfor
  return candidates
endfunction "}}}


function! neocomplete#sources#buffer_lcc#define() abort "{{{
  return s:source
endfunction "}}}


let &cpo = s:save_cpo
unlet s:save_cpo
