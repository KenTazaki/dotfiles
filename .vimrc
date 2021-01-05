"vimの設定(http://qiita.com/delphinus/items/00ff2c0ba972c6e41542)

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  " let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  " call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif 

colorscheme molokai
syntax on
"Charset, Line ending -----------------
set encoding=utf-8
scriptencoding utf-8


" 見た目系
filetype plugin indent on
set autoindent            " 自動インデントを有効に
set ambiwidth=double      " 全角記号の表示幅を修正
set number                " 行番号を表示
"set cursorline            " 現在の行を強調表示
set scrolloff=8           " 上下8行の視界を確保
set ttyfast               " カーソル移動高速化
set autoread              " 外部でファイルに変更がされた場合は読みなおす
"INSERTモードのときだけ横線解除
augroup set_cursorline
  autocmd!
  autocmd InsertEnter,InsertLeave * set cursorline!  "redraw!
augroup END
set virtualedit=onemore   " 行末の1文字先までカーソルを移動できるように
set smartindent           " インデントはスマートインデント
set visualbell            " ビープ音を可視化
set showmatch             " 括弧入力時の対応する括弧を表示
set laststatus=2        " ステータスラインを常に表示
set wildmode=list:longest " コマンドラインの補完
" nnoremap j gj             " 折り返し時に表示行単位での移動できるようにする
" nnoremap k gk
" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :
nnoremap : ;

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる(インクリメンタルサーチ)
set incsearch
" 検索時に最後まで行ったら最初に戻る set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nnoremap <Esc><Esc> :nohlsearch<CR>

" colorscheme
colorscheme badwolf

" Syntax highlight ---------------
syntax on                    "シンタクスハイライトを有効化


set t_Co=256

augroup add_syntax_hilight
  autocmd!
  "シンタックスハイライトの追加
  autocmd BufNewFile,BufRead *.json.jbuilder            set ft=ruby
  autocmd BufNewFile,BufRead *.erb                      set ft=eruby
  autocmd BufNewFile,BufRead *.scss                     set ft=scss.css
  autocmd BufNewFile,BufRead *.coffee                   set ft=coffee
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set ft=markdown
augroup END

"=======================コピー&ペースト系=================
" クリップボード
set clipboard=unnamed,autoselect



"----------コピーした際に自動インデントでズレない設定----
if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif
"----------------------------------------------------


"タブ表示について(https://qiita.com/wadako111/items/755e753677dd72d8036dを参考)
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
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ
