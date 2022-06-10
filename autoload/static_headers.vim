scriptencoding utf-8

if exists('g:static_headers_autoloaded')
  finish
endif

let g:static_headers_autoloaded = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:static_headers_lines = get(g:, 'static_headers_lines', 4)
if exists('*nvim_create_namespace')
  let s:static_headers_namespace = nvim_create_namespace('static_headers')
endif

function! static_headers#BufferEnter()
  if g:static_headers_enabled == 0
    return
  endif

  call static_headers#StartBufferTracking()
endfunction

function! static_headers#BufferExit()
  if g:static_headers_enabled == 0
    return
  endif

  call static_headers#StopBufferTracking()
endfunction

function! static_headers#StartBufferTracking() abort
  " autocmd! CursorMoved * :call
  echo 'tracking'
endfunction

function! static_headers#StopBufferTracking() abort
  " autocmd! CursorMoved * :call
  let s:static_headers_allowed_files = ['ts', 'html', 'js', 'go', 'css', 'sass', 'scss']
  let s:extension = split(bufname(), '\.')[-1]
  let s:allowed_extension = 0
  for e in s:static_headers_allowed_files
    if s:allowed_extension == e
      s:allowed_extension = 1
    endif
  endfor

  if s:allowed_extension == 0
    return
  endif

  echo 'tracking'
endfunction

function! static_headers#Init() abort
  if g:static_headers_initialized == 1
    return
  endif

  let g:static_headers_initialized = 1

  augroup vim_static_headers
    autocmd!
    autocmd! BufEnter * :call static_headers#BufferEnter()
    autocmd! BufEnter * :call static_headers#BufferExit()
  augroup END
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
