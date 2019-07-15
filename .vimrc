" シンタックスハイライト
syntax on
" エンコード
set encoding=utf8
" 行番号を表示
set number
" 右下に表示される行、列の番号を表示する
set ruler
" 対応括弧にのペアを追加
set matchpairs& matchpairs+=<:>
" 対応括弧をハイライト表示する
set showmatch
" 対応括弧の表示秒数を3秒にする
set matchtime=3
" ウィンドウの幅より長い行は折り返され、次の行に続けて表示される
set wrap
" 入力されているテキストの最大幅を無効にする
"set textwidth=0
" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" 検索結果をハイライト表示
:set hlsearch
" コマンドを画面最下部に表示する(動作が遅くなるため、一旦コメントアウト)
set showcmd
" キーバーインドLeader
let mapleader = "\<Space>"
" ファイル保存
nnoremap <Leader>w :w<CR>
"ビジュアルラインモードに切り替える
nmap <Leader><Leader> V

" タブ、スペースの設定
set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=2 "画面上でタブ文字が占める幅
set shiftwidth=2 "自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

" 入力補完ウィンドウ色設定
hi Pmenu ctermbg=5
hi PmenuSel ctermbg=8
hi PmenuSbar ctermbg=2
hi PmenuThumb ctermfg=3
" コメントの色設定
hi Comment ctermfg=2

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" vを二回で行末まで選択
vnoremap v $h
" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/  /ge

":grepで自動的にquickfix-windowを開く
"autocmd QuickFixCmdPost *grep* cwindow

" ウィンドウ分割を楽にする設定
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sN :<C-u>new<CR>
nnoremap sV :<C-u>vnew<CR>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap s+ <C-w>+
nnoremap s- <C-w>-

"タブ操作
nnoremap st :<C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]>

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    s [Tag]

" Tab jump
" s1 で1番左のタブ、s2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" インサートモード時にバックスペースを使う
set backspace=indent,eol,start

"ヤンクでクリップボードにコピー
set clipboard=unnamed,autoselect

" 全角スペースのハイライトを設定
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction

" crontab
if $VIM_CRONTAB == "true"
    set nobackup
    set nowritebackup
endif

"---------------------------
" Start Neobundle Settings.
"---------------------------
" vim-tagsでtagsファイルを自動で作成する設定
let g:vim_tags_project_tags_command = '/usr/local/bin/ctags --exclude="*.js"  --exclude=".git*" -f .tags -R . 2>/dev/null'
let g:vim_tags_gems_tags_command = '/usr/local/bin/ctags -R -f .Gemfile.lock.tags `bundle show --paths` 2>/dev/null'
set tags+=.tags
set tags+=.Gemfile.lock.tags

" vim-ref設定
let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe' "refeコマンドのパス
let g:ref_open = 'vsplit'
let g:ref_refe_version = 2
nnoremap ,,r :<C-U>Ref refe<Space>

set nocompatible
filetype off

if has('vim_starting')
  " bundleで管理するディレクトリを指定
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif

"insert here your Neobundle plugins"
call neobundle#begin(expand('~/.vim/bundle/'))
  NeoBundle 'scrooloose/nerdtree'
  " 閉じるendを自動挿入
  NeoBundle 'tpope/vim-endwise'
  " ファイルオープンを便利に
  NeoBundle 'Shougo/unite.vim'
  " Unite.vimで最近使ったファイルを表示できるようにする
  NeoBundle 'Shougo/neomru.vim'
  " 入力補完機能を提供する
  NeoBundle 'Shougo/neocomplcache'
  " rubyの静的ソース解析
  NeoBundle 'scrooloose/syntastic'
  " メソッド定義元へのジャンプ設定を自動更新
  NeoBundle 'szw/vim-tags'
  " 高速ファイル検索
  NeoBundle 'ctrlpvim/ctrlp.vim'
  NeoBundle 'rking/ag.vim'
  " markdownのプレビュー表示
  NeoBundle 'plasticboy/vim-markdown'
  NeoBundle 'kannokanno/previm'
  NeoBundle 'tyru/open-browser.vim'
  " rubyリファレンスを検索する
  NeoBundle 'thinca/vim-ref'
  " vim上でgit操作を行う
  NeoBundle 'jreybert/vimagit'
  " vimペースト時にautoindentを無効にする
  NeoBundle 'ConradIrwin/vim-bracketed-paste'

  " ruby補完機能を提供する
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \    },
        \ }
  " ステータスラインのカスタマイズ
  NeoBundle 'itchyny/lightline.vim'
  " rubyリファレンスの参照
  NeoBundle 'thinca/vim-ref'
  " python 補完
  NeoBundle 'davidhalter/jedi-vim'
  " python 構文エラーの検出
  NeoBundleLazy "nvie/vim-flake8", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
  " python indent
  NeoBundle 'nathanaelkane/vim-indent-guides'

call neobundle#end()

filetype plugin indent on

" vim内でgitを便利に使うためのプラグイにおける設定
let g:magit_default_show_all_files = 2  "全ファイルのdiffを表示
let g:magit_default_fold_level = 2  "hunkの中身のdiffも表示
let g:magit_default_sections = ['global_help', 'info', 'unstaged', 'staged', 'commit'] "各セクションの表示順序

" 高速ファイル検索(Ag)の設定
if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif

" markdownプレビュー表示の設定
au BufRead,BufNewFile *.md set filetype=markdown
"   Need: kannokanno/previm
nnoremap <silent> pvo :PrevimOpen<CR> " pvoでプレビュー
"   自動で折りたたまないようにする
let g:vim_markdown_folding_disabled=1

" vim内でgitをGUIぽく処理する
"let g:magit_show_help = 0  " ヘルプ非表示化
let g:magit_default_show_all_files = 2  "全ファイルのdiffを表示
let g:magit_default_fold_level = 2 "hunkの中身のdiffも表示
let g:magit_default_sections = ['global_help', 'info', 'unstaged', 'staged', 'commit']

" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
NeoBundleCheck

"-------------------------
" End Neobundle Settings.
"-------------------------

"-------------------------
" [python] vim-flake8
"------------------------
"保存時に自動でチェック
let g:PyFlakeOnWrite = 1
"解析種別を設定
let g:PyFlakeCheckers = 'pep8,mccabe,pyflakes'
"McCabe複雑度の最大値
let g:PyFlakeDefaultComplexity=10
"visualモードでQを押すと自動で修正
let g:PyFlakeRangeCommand = 'Q'

"-------------------------
" [python] vim-indent-guides
"------------------------
" display indent from init
" non clear display indent always
"let g:indent_guides_enable_on_vim_startup = 1

"-------------------------
" Unit.vimの設定
"-------------------------
" 入力モードで開始する
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200

" 隠しファイルをデフォルトで表示させる
let NERDTreeShowHidden = 1
" デフォルトでツリーを表示させる
"autocmd VimEnter * execute 'NERDTree'

"NERDTreeを開く
nnoremap <silent> ,ue :<C-u>NERDTreeToggle<CR>
"ヤンクの履歴
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使ったファイルの一覧とバッファを表示
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>
" ファイル非同期検索
nnoremap <silent> ,up  :<C-u>Unite file_rec/async:!<CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"-------------------------
" neocomplcache設定
"-------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : ''
      \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" --------------------------------
" rubocop
" --------------------------------
" syntastic_mode_mapをactiveにするとバッファ保存時にsyntasticが走る
" active_filetypesに、保存時にsyntasticを走らせるファイルタイプを指定する
let g:syntastic_mode_map = {
      \ 'mode': 'passive',
      \ 'active_filetypes': ['ruby'],
      \ 'passive_filetypes': ['python']
      \ }
let g:syntastic_ruby_checkers = ['rubocop']
