if exists("g:static_headers_loaded")
	finish
endif

let g:static_header_loaded = 1
let g:static_headers_initialized = 0

let s:save_cpo = &cpo
set cpo&vim

let g:static_headers_enabled = get(g:, 'static_headers_enabled', 0)

function! StaticHeadersEnable() abort
	call static_headers#Enable()
endfunction

function! StaticHeadersDisable() abort
	call static_headers#Disable()
endfunction

function! StaticHeadersToggle() abort
	if g:static_headers_enabled == 0
		call StaticHeadersEnable()
	else
		call StaticHeadersDisable()
	endif
endfunction

call static_headers#Init()

:command! -nargs=0 StaticHeadersEnable call StaticHeadersEnable()
:command! -nargs=0 StaticHeadersDisable call StaticHeadersDisable()
:command! -nargs=0 StaticHeadersToggle call StaticHeadersToggle()

let &cpo = s:save_cpo
unlet s:save_cpo
