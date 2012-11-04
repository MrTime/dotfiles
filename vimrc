call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
call pathogen#infect()

if has("autocmd")
  filetype on
  filetype plugin indent on

"  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,thor,haml,css,eruby,yaml,html,sass,cucumber,coffee setlocal ai ts=2 sw=2 sts=2 et
  autocmd FileType javascript setlocal ai ts=4 sw=4 sts=4 noet

  autocmd BufRead,BufNewFile *.thor,Rakefile,Gemfile,Guardfile,config.ru set filetype=ruby
  autocmd BufWritePost .vimrc source $MYVIMRC
  autocmd BufReadPost fugirive://* set bufhidden=delete
endif

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

set number
set hidden

" showing symbols
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
set list listchars=tab:▸\ ,eol:¬

" tabs and spaces
set ai sts=2 sw=2 et

let mapleader=','
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <Leader>ew :e %%
map <Leader>es :sp %%
map <Leader>ev :vsp %%
map <Leader>et :tabe %%

" Visually select the test that was last edited/pasted
nmap gV `[v`]

nnoremap <silent> <Plug>unimpairedMoveUp   :<C-U>exe 'norm m`'<Bar>exe 'move--'.v:count1<CR>``
nnoremap <silent> <Plug>unimpairedMoveDown :<C-U>exe 'norm m`'<Bar>exe 'move+'.v:count1<CR>``
xnoremap <silent> <Plug>unimpairedMoveUp   :<C-U>exe 'norm m`'<Bar>exe '''<,''>move--'.v:count1<CR>``
xnoremap <silent> <Plug>unimpairedMoveDown :<C-U>exe 'norm m`'<Bar>exe '''<,''>move''>+'.v:count1<CR>``

nmap [e <Plug>unimpairedMoveUp
nmap ]e <Plug>unimpairedMoveDown
xmap [e <Plug>unimpairedMoveUp
xmap ]e <Plug>unimpairedMoveDown

" Buddle single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Buddle multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

"nmap <D-[> <<
"nmap <D-]> >>
"nmap <D-[> <gv
"nmap <D-]> >gv


"map W :%s/ *$//g<cr><c-o><cr>

" установить keymap, чтобы по Ctrl+^ переключался на русский и обратно
"set keymap=russian-jcukenwin 
" по умолчанию - латинская раскладка
"set iminsert=0
" по умолчанию - латинская раскладка при поиске
"set imsearch=0
" игнорировать регистр при поиске
"set ic
" подсвечивать поиск
"set hls
" использовать инкрементальный поиск
"set is
" минимальная высота окна пусть будет 0 (по умолчанию - 1)
"set winminheight=0
" всегда делать активное окно максимального размера
"set noequalalways
"set winheight=9999
" установить шрифт Courier New Cyr
"set guifont=courier_new:h10:cRUSSIAN
" настраиваю для работы с русскими словами (чтобы w, b, * понимали
" русские слова)
"set iskeyword=@,48-57,_,192-255
" отображение выполняемой команды
set showcmd 
" перенос по словам, а не по буквам
set nowrap
"set dy=lastline

set mouse=a
"map <S-Insert> <MiddleMouse>
"map! <S-Insert> <MiddleMouse>
"

function MakeRVMGemsetTags ()
  let gemset = substitute(system('rvm current'), "\n","","")
  let full_gemset_tags_path = $HOME."/.vim/tags/".gemset

  if !filereadable(full_gemset_tags_path)
    let gems_path = $GEM_HOME."/gems"
    let ctags_cmd = "ctags -f ".full_gemset_tags_path." -R ".gems_path
    execute "!".ctags_cmd
  endif

  execute "set tags+=".full_gemset_tags_path
  return full_gemset_tags_path
endfunction

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R .<CR>

" build tags of your current gemset with Ctrl-F11
map <C-F11> :call MakeRVMGemsetTags()<CR>

if filereadable('.rvmrc')
  call MakeRVMGemsetTags()
endif
